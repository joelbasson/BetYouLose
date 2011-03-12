module ApplicationHelper
  
  def error_div_for(model)
      raw  %{<div id="errors_for_#{model.class.name.underscore}"></div>}
  end
  
  def get_credit_value
    APP_CONFIG["credit_value"].to_d
  end
  
  def def_cur
    APP_CONFIG["default_currency"]
  end

end
