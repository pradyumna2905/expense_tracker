module ExpensesHelper
  def active_month_link(month)
    active_link_to month.upcase,
      expenses_path(month: month, year: Date.current.year),
      active: active_month,
      class: 'month-link'
  end

  def active_month
    if request.query_parameters.has_key?("month") &&
        valid_month?(request.query_parameters["month"])
      # /#{month}/i
      /#{request.query_parameters["month"]}/i
    else
      /#{Date.current.strftime("%B")}/i
    end
  end

  def valid_month?(month)
    Date::MONTHNAMES.compact.map(&:downcase).include?(month.to_s.downcase)
  end
end
