require 'json'
require 'net/http'

class Component < ActiveRecord::Base
  belongs_to  :category
  has_many    :properties
  has_many    :bom_items

  validates :name, :manufacturer, :description, presence: :true
  validates :price, :distributor, presence: :true

  scope :sorted, -> { order(:name) }

  def self.search_by_name(query)
    return [] if query.blank?
    where("name ILIKE ?", "%#{query}%").all.sorted
  end

  def current_price
    if !last_priced || last_priced < 2.days.ago
      octopart_query
      octopart_update
    end
    price
  end

  def current_distributor
    if !last_priced || last_priced < 2.days.ago
      octopart_query
      octopart_update
    end
    distributor
  end

  private

  def octopart_update
    update( price: octopart_price,
            last_priced: DateTime.now,
            distributor: octopart_distributor )
  end
  
  def octopart_query
    url = "http://octopart.com/api/v3/parts/match?apikey="
    url += ENV["OCTOPART_API_KEY"]

    queries = [{mpn: name}]

    url += "&queries=" + URI.encode(JSON.generate(queries))

    resp = Net::HTTP.get_response(URI.parse(url))
    @response = JSON.parse(resp.body)
  end

  def octopart_price
    if @response['results'][0]['items'][0]['offers'][0]['prices'] != {}
      @response['results'][0]['items'][0]['offers'][0]['prices']['USD'][0][1].to_f
    else
      0
    end
  end

  def octopart_distributor
    if @response['results'][0]['items'][0]['offers'][0]['seller'] != {}
      @response['results'][0]['items'][0]['offers'][0]['seller']['name']
    else
      ''
    end
  end

end