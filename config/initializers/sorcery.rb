# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external
Rails.application.config.sorcery.submodules = [:activity_logging, :brute_force_protection, :external, :remember_me, :reset_password, :user_activation]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  # -- core --
  # What controller action to call for non-authenticated users. You can also
  # override the 'not_authenticated' method of course.
  # Default: `:not_authenticated`
  #
  config.not_authenticated_action = :user_not_authorized

  # When a non logged in user tries to enter a page that requires login, save
  # the URL he wanted to reach, and send him there after login, using 'redirect_back_or_to'.
  # Default: `true`
  #
  # config.save_return_to_url =

  # Set domain option for cookies; Useful for remember_me submodule.
  # Default: `nil`
  #
  # config.cookie_domain =

  # Allow the remember_me cookie to be set through AJAX
  # Default: `true`
  #
  # config.remember_me_httponly =

  # -- session timeout --
  # How long in seconds to keep the session alive.
  # Default: `3600`
  #
  # config.session_timeout =

  # Use the last action as the beginning of session timeout.
  # Default: `false`
  #
  # config.session_timeout_from_last_action =

  # -- http_basic_auth --
  # What realm to display for which controller name. For example {"My App" => "Application"}
  # Default: `{"application" => "Application"}`
  #
  # config.controller_to_realm_map =

  # -- activity logging --
  # will register the time of last user login, every login.
  # Default: `true`
  #
  # config.register_login_time =

  # will register the time of last user logout, every logout.
  # Default: `true`
  #
  # config.register_logout_time =

  # will register the time of last user action, every action.
  # Default: `true`
  #
  # config.register_last_activity_time =

  # -- external --
  # What providers are supported by this app, i.e. [:twitter, :facebook, :github, :linkedin, :xing, :google, :liveid, :salesforce, :slack] .
  # Default: `[]`
  #
  config.external_providers = [:facebook, :twitter, :google, :microsoft]

  # You can change it by your local ca_file. i.e. '/etc/pki/tls/certs/ca-bundle.crt'
  # Path to ca_file. By default use a internal ca-bundle.crt.
  # Default: `'path/to/ca_file'`
  #
  # config.ca_file =
  #
  #############
  ## Twitter ##
  #############
  #
  # Twitter will not accept any requests nor redirect uri containing localhost,
  # make sure you use 0.0.0.0:3000 to access your app in development
  #
  config.twitter.key = ENV['AEON_TWITTER_KEY']
  config.twitter.secret = ENV['AEON_TWITTER_SECRET']
  config.twitter.callback_url = "https://#{Rails.configuration.x.url}/oauth/callback/twitter"
  config.twitter.user_info_mapping = { username: 'screen_name',
                                       realname: 'name',
                                       bio: 'description',
                                       location: 'location',
                                       website: 'url',
                                       locale: 'lang',
                                       timezone: 'time_zone' }
  #
  ##############
  ## Facebook ##
  ##############
  #
  config.facebook.key = ENV['AEON_FACEBOOK_KEY']
  config.facebook.secret = ENV['AEON_FACEBOOK_SECRET']
  config.facebook.callback_url = "https://#{Rails.configuration.x.url}/oauth/callback/facebook"
  config.facebook.user_info_path = 'me?fields=name,email,locale,timezone'
  config.facebook.user_info_mapping = { realname: 'name',
                                        email: 'email',
                                        locale: 'locale',
                                        timezone: 'timezone' }
  config.facebook.access_permissions = ['public_profile', 'email']
  config.facebook.display = 'page'
  config.facebook.api_version = 'v2.8'
  #
  ############
  ## Google ##
  ############
  #
  config.google.key = ENV['AEON_GOOGLE_KEY']
  config.google.secret = ENV['AEON_GOOGLE_SECRET']
  config.google.callback_url = "https://#{Rails.configuration.x.url}/oauth/callback/google"
  config.google.user_info_mapping = { realname: 'name',
                                      email: 'email',
                                      locale: 'locale' }
  config.google.scope = 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile'
  #
  ###############
  ## Microsoft ##
  ###############
  #
  # For Microsoft Graph, the key will be your App ID, and the secret will be your app password/public key.
  # The callback URL "can't contain a query string or invalid special characters", see: https://docs.microsoft.com/en-us/azure/active-directory/active-directory-v2-limitations#restrictions-on-redirect-uris
  # More information at https://graph.microsoft.io/en-us/docs
  #
  config.microsoft.key = ENV['AEON_MICROSOFT_KEY']
  config.microsoft.secret = ENV['AEON_MICROSOFT_SECRET']
  config.microsoft.callback_url = "https://#{Rails.configuration.x.url}/oauth/callback/microsoft"
  config.microsoft.user_info_mapping = { realname: 'displayName',
                                         email: 'userPrincipalName',
                                         locale: 'preferredLanguage' }
  config.microsoft.scope = 'openid email https://graph.microsoft.com/User.Read'

  # --- user config ---
  config.user_config do |user|
    # -- core --
    # specify username attributes, for example: [:username, :email].
    # Default: `[:email]`
    #
    user.username_attribute_names = [:username, :email]

    # change *virtual* password attribute, the one which is used until an encrypted one is generated.
    # Default: `:password`
    #
    # user.password_attribute_name =

    # downcase the username before trying to authenticate, default is false
    # Default: `false`
    #
    # user.downcase_username_before_authenticating = true

    # change default email attribute.
    # Default: `:email`
    #
    # user.email_attribute_name =

    # change default crypted_password attribute.
    # Default: `:crypted_password`
    #
    # user.crypted_password_attribute_name =

    # what pattern to use to join the password with the salt
    # Default: `""`
    #
    # user.salt_join_token =

    # change default salt attribute.
    # Default: `:salt`
    #
    # user.salt_attribute_name =

    # how many times to apply encryption to the password.
    # Default: `nil`
    #
    # user.stretches =

    # encryption key used to encrypt reversible encryptions such as AES256.
    # WARNING: If used for users' passwords, changing this key will leave passwords undecryptable!
    # Default: `nil`
    #
    # user.encryption_key =

    # use an external encryption class.
    # Default: `nil`
    #
    # user.custom_encryption_provider =

    # encryption algorithm name. See 'encryption_algorithm=' for available options.
    # Default: `:bcrypt`
    #
    # user.encryption_algorithm =

    # make this configuration inheritable for subclasses. Useful for ActiveRecord's STI.
    # Default: `false`
    #
    # user.subclasses_inherit_config =

    # -- remember_me --
    # How long in seconds the session length will be
    # Default: `604800`
    #
    # user.remember_me_for =

    # when true sorcery will persist a single remember me token for all
    # logins/logouts (supporting remembering on multiple browsers simultaneously).
    # Default: false
    #
    # user.remember_me_token_persist_globally =

    # -- user_activation --
    # the attribute name to hold activation state (active/pending).
    # Default: `:activation_state`
    #
    # user.activation_state_attribute_name =

    # the attribute name to hold activation code (sent by email).
    # Default: `:activation_token`
    #
    # user.activation_token_attribute_name =

    # the attribute name to hold activation code expiration date.
    # Default: `:activation_token_expires_at`
    #
    # user.activation_token_expires_at_attribute_name =

    # how many seconds before the activation code expires. nil for never expires.
    # Default: `nil`
    #
    # user.activation_token_expiration_period = 3.hours

    # your mailer class. Required.
    # Default: `nil`
    #
    user.user_activation_mailer = UserMailer

    # when true sorcery will not automatically
    # email activation details and allow you to
    # manually handle how and when email is sent.
    # Default: `false`
    #
    # user.activation_mailer_disabled =

    # method to send email related
    # options: `:deliver_later`, `:deliver_now`, `:deliver`
    # Default: :deliver (Rails version < 4.2) or :deliver_now (Rails version 4.2+)
    #
    # user.email_delivery_method =

    # activation needed email method on your mailer class.
    # Default: `:activation_needed_email`
    #
    # user.activation_needed_email_method_name =

    # activation success email method on your mailer class.
    # Default: `:activation_success_email`
    #
    # user.activation_success_email_method_name =

    # do you want to prevent or allow users that did not activate by email to login?
    # Default: `true`
    #
    # user.prevent_non_active_users_to_login =

    # -- reset_password --
    # reset password code attribute name.
    # Default: `:reset_password_token`
    #
    # user.reset_password_token_attribute_name =

    # expires at attribute name.
    # Default: `:reset_password_token_expires_at`
    #
    # user.reset_password_token_expires_at_attribute_name =

    # when was email sent, used for hammering protection.
    # Default: `:reset_password_email_sent_at`
    #
    # user.reset_password_email_sent_at_attribute_name =

    # mailer class. Needed.
    # Default: `nil`
    #
    user.reset_password_mailer = UserMailer

    # reset password email method on your mailer class.
    # Default: `:reset_password_email`
    #
    # user.reset_password_email_method_name =

    # when true sorcery will not automatically
    # email password reset details and allow you to
    # manually handle how and when email is sent
    # Default: `false`
    #
    # user.reset_password_mailer_disabled =

    # how many seconds before the reset request expires. nil for never expires.
    # Default: `nil`
    #
    # user.reset_password_expiration_period =

    # hammering protection, how long in seconds to wait before allowing another email to be sent.
    # Default: `5 * 60`
    #
    # user.reset_password_time_between_emails =

    # -- brute_force_protection --
    # Failed logins attribute name.
    # Default: `:failed_logins_count`
    #
    # user.failed_logins_count_attribute_name =

    # This field indicates whether user is banned and when it will be active again.
    # Default: `:lock_expires_at`
    #
    # user.lock_expires_at_attribute_name =

    # How many failed logins allowed.
    # Default: `50`
    #
    # user.consecutive_login_retries_amount_limit =

    # How long the user should be banned. in seconds. 0 for permanent.
    # Default: `60 * 60`
    #
    # user.login_lock_time_period =

    # Unlock token attribute name
    # Default: `:unlock_token`
    #
    # user.unlock_token_attribute_name =

    # Unlock token mailer method
    # Default: `:send_unlock_token_email`
    #
    # user.unlock_token_email_method_name =

    # when true sorcery will not automatically
    # send email with unlock token
    # Default: `false`
    #
    # user.unlock_token_mailer_disabled = true

    # Unlock token mailer class
    # Default: `nil`
    #
    # user.unlock_token_mailer = UserMailer

    # -- activity logging --
    # Last login attribute name.
    # Default: `:last_login_at`
    #
    # user.last_login_at_attribute_name =

    # Last logout attribute name.
    # Default: `:last_logout_at`
    #
    # user.last_logout_at_attribute_name =

    # Last activity attribute name.
    # Default: `:last_activity_at`
    #
    # user.last_activity_at_attribute_name =

    # How long since last activity is the user defined logged out?
    # Default: `10 * 60`
    #
    # user.activity_timeout =

    # -- external --
    # Class which holds the various external provider data for this user.
    # Default: `nil`
    #
    user.authentications_class = Authentication

    # User's identifier in authentications class.
    # Default: `:user_id`
    #
    # user.authentications_user_id_attribute_name =

    # Provider's identifier in authentications class.
    # Default: `:provider`
    #
    # user.provider_attribute_name =

    # User's external unique identifier in authentications class.
    # Default: `:uid`
    #
    # user.provider_uid_attribute_name =
  end

  # This line must come after the 'user config' block.
  # Define which model authenticates with sorcery.
  config.user_class = User
end
