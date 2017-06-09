module ApplicationHelper
  def formatted_date(date)
    date.strftime("%B %d, %Y")
  end
end
