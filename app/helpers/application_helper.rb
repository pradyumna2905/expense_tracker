module ApplicationHelper
  def navbar_link_to(text, path)
    active_link_to text.to_s.upcase, path,
      class: "sub-nav-link"
  end
end
