module ApplicationHelper
  def formatted_date(date)
    date.strftime("%B %d, %Y")
  end

  def sub_nav_link(text, path)
    link_to text.to_s, path,
      class: "sub-nav-link"
  end
end
