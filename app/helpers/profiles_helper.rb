module ProfilesHelper
  def fake_masked_password
    "#{'*' * 8}".html_safe
  end
end
