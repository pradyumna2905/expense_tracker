module DateHelper
  def formatted_date(date)
    date.strftime("%B %d, %Y")
  end

  def month_names
    Date::MONTHNAMES.compact
  end
end
