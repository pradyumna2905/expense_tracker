module ApplicationHelper
  def navbar_link_to(text, path)
    active_link_to text.to_s.upcase, path,
      class: "sub-nav-link"
  end

  def mail_me
    mail_to "pradyumna2905@gmail.com", "reach out to me",
      subject: "AS"
  end
end
