module ApplicationHelper
  def formatted_date(date)
    date.strftime("%B %d, %Y")
  end

  def navbar_link_to(text, path)
    active_link_to text.to_s.upcase, path,
      class: "sub-nav-link"
  end
end
