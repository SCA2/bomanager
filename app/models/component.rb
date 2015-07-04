require 'json'
require 'net/http'

class Component < ActiveRecord::Base
  belongs_to  :category
  has_many    :properties
  has_many    :bom_items

  validates :name, :manufacturer, :description, presence: :true

  scope :sorted, -> { order(:name) }

  def self.search_by_name(query)
    return [] if query.blank?
    where("name ILIKE ?", "%#{query}%").all.sorted
  end

  def price

    url = "http://octopart.com/api/v3/parts/search?apikey="
    url += ENV["OCTOPART_API_KEY"]
    
    def to_query(hsh)
      hsh.map {|k, v| "#{k}=#{URI.encode(v.to_s)}"}.join("&")
    end

    params = {
      q: name,
      start: 0,
      limit: 10,
      # sortby: "offers.prices.USD asc, offers.in_stock_quantity desc"
    }

    url += "&" + to_query(params)

    resp = Net::HTTP.get_response(URI.parse(url))
    search_response = JSON.parse(resp.body)

    if search_response['results'][0]['item']['offers'][0]['prices'] != {}
      search_response['results'][0]['item']['offers'][0]['prices']['USD'][0][1].to_f
    else
      0
    end
  end
end