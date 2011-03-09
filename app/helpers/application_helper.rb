module ApplicationHelper
  
  def error_div_for(model)
      raw  %{<div id="errors_for_#{model.class.name.underscore}"></div>}
  end
  
end
