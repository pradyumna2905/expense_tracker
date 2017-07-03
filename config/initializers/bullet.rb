Rails.application.configure do
  config.after_initialize do
    if Rails.env.development?
      Bullet.enable = true
      Bullet.alert = true
      Bullet.bullet_logger = true
      Bullet.console = true
    end
  end
end
