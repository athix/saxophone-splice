Recaptcha.configure do |config|
  # Set Key/Secret
  config.site_key  = ENV['AEON_RECAPTCHA_KEY']
  config.secret_key = ENV['AEON_RECAPTCHA_SECRET']

  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'

  # Test is skipped by default, add development as well.
  config.skip_verify_env << 'development'
end
