module ApplicationHelper
  def bom_options(selected=nil)
    options = current_user.boms.map {|bom| [bom.name, bom.id] }
    options = options.to_h
    options['Create new'] = nil
    options_for_select(options, selected)
  end
end
