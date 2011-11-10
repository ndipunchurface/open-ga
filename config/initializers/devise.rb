# Use this hook to configure devise mailer, warden hooks and so forth. The first
# four configuration values can also be set straight in your models.
Devise.setup do |config|
  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in Devise::Mailer,
  # note that it will be overwritten if you use your own mailer class with default "from" parameter.
  config.mailer_sender = DEVISE_CONFIG['mailer_sender']

  # Configure the class responsible to send e-mails.
  config.mailer = "Devise::Mailer"

  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'devise/orm/active_record'

  # ==> Configuration for any authentication mechanism
  # Configure which keys are used when authenticating a user. The default is
  # just :email. You can configure it to use [:username, :subdomain], so for
  # authenticating a user, both parameters are required. Remember that those
  # parameters are used only when authenticating and not when retrieving from
  # session. If you need permissions, you should implement that in a before filter.
  # You can also supply a hash where the value is a boolean determining whether
  # or not authentication should be aborted when the value is not present.
  config.authentication_keys = DEVISE_CONFIG['authentication_keys'].map! {|i| i.to_sym}

  # Configure parameters from the request object used for authentication. Each entry
  # given should be a request method and it will automatically be passed to the
  # find_for_authentication method and considered in your model lookup. For instance,
  # if you set :request_keys to [:subdomain], :subdomain will be used on authentication.
  # The same considerations mentioned for authentication_keys also apply to request_keys.
  # config.request_keys = []

  # Configure which authentication keys should be case-insensitive.
  # These keys will be downcased upon creating or modifying a user and when used
  # to authenticate or find a user. Default is :email.
  config.case_insensitive_keys = DEVISE_CONFIG['case_insensitive_keys'].map! {|i| i.to_sym}

  # Configure which authentication keys should have whitespace stripped.
  # These keys will have whitespace before and after removed upon creating or
  # modifying a user and when used to authenticate or find a user. Default is :email.
  config.strip_whitespace_keys = DEVISE_CONFIG['strip_whitespace_keys'].map! {|i| i.to_sym}

  # Tell if authentication through request.params is enabled. True by default.
  config.params_authenticatable = DEVISE_CONFIG['params_authenticatable']

  # Tell if authentication through HTTP Basic Auth is enabled. False by default.
  config.http_authenticatable = DEVISE_CONFIG['http_authenticatable']

  # If http headers should be returned for AJAX requests. True by default.
  config.http_authenticatable_on_xhr = DEVISE_CONFIG['http_authenticatable_on_xhr']

  # The realm used in Http Basic Authentication. "Application" by default.
  config.http_authentication_realm = DEVISE_CONFIG['http_authentication_realm']

  # It will change confirmation, password recovery and other workflows
  # to behave the same regardless if the e-mail provided was right or wrong.
  # Does not affect registerable.
  config.paranoid = DEVISE_CONFIG['paranoid']

  # ==> Configuration for :database_authenticatable
  # For bcrypt, this is the cost for hashing the password and defaults to 10. If
  # using other encryptors, it sets how many times you want the password re-encrypted.
  #
  # Limiting the stretches to just one in testing will increase the performance of
  # your test suite dramatically. However, it is STRONGLY RECOMMENDED to not use
  # a value less than 10 in other environments.
  config.stretches = (Rails.env.test? || Rails.env.development?) ? 1 : DEVISE_CONFIG['stretch']

  # Setup a pepper to generate the encrypted password.
  config.pepper = DEVISE_CONFIG['pepper']

  # ==> Configuration for :confirmable
  # A period that the user is allowed to access the website even without
  # confirming his account. For instance, if set to 2.days, the user will be
  # able to access the website for two days without confirming his account,
  # access will be blocked just in the third day. Default is 0.days, meaning
  # the user cannot access the website without confirming his account.
  config.confirm_within = eval DEVISE_CONFIG['confirm_within']

  # Defines which key will be used when confirming an account
  config.confirmation_keys = DEVISE_CONFIG['confirmation_keys'].map! {|i| i.to_sym}

  # ==> Configuration for :rememberable
  # The time the user will be remembered without asking for credentials again.
  config.remember_for = eval DEVISE_CONFIG['remember_for']

  # If true, a valid remember token can be re-used between multiple browsers.
  config.remember_across_browsers = DEVISE_CONFIG['remember_across_browsers']

  # If true, extends the user's remember period when remembered via cookie.
  config.extend_remember_period = DEVISE_CONFIG['extend_remember_period']

  # If true, uses the password salt as remember token. This should be turned
  # to false if you are not using database authenticatable.
  config.use_salt_as_remember_token = DEVISE_CONFIG['use_salt_as_remember_token']

  # ==> Configuration for :validatable
  # Range for password length. Default is 6..128.
  config.password_length = DEVISE_CONFIG['password_length']['min']..DEVISE_CONFIG['password_length']['max']

  # Email regex used to validate email formats. It simply asserts that
  # an one (and only one) @ exists in the given string. This is mainly
  # to give user feedback and not to assert the e-mail validity.
  config.email_regexp = Regexp.new(DEVISE_CONFIG['email_regexp'])

  # ==> Configuration for :timeoutable
  # The time you want to timeout the user session without activity. After this
  # time the user will be asked for credentials again. Default is 30 minutes.
  config.timeout_in = eval DEVISE_CONFIG['timeout_in']

  # ==> Configuration for :lockable
  # Defines which strategy will be used to lock an account.
  # :failed_attempts = Locks an account after a number of failed attempts to sign in.
  # :none            = No lock strategy. You should handle locking by yourself.
  config.lock_strategy = DEVISE_CONFIG['lock_strategy'].to_sym

  # Defines which key will be used when locking and unlocking an account
  config.unlock_keys = DEVISE_CONFIG['unlock_keys'].map! {|i| i.to_sym}

  # Defines which strategy will be used to unlock an account.
  # :email = Sends an unlock link to the user email
  # :time  = Re-enables login after a certain amount of time (see :unlock_in below)
  # :both  = Enables both strategies
  # :none  = No unlock strategy. You should handle unlocking by yourself.
  config.unlock_strategy = DEVISE_CONFIG['unlock_strategy'].to_sym

  # Number of authentication tries before locking an account if lock_strategy
  # is failed attempts.
  config.maximum_attempts = DEVISE_CONFIG['maximum_attempts']

  # Time interval to unlock the account if :time is enabled as unlock_strategy.
  config.unlock_in = eval DEVISE_CONFIG['unlock_in']

  # ==> Configuration for :recoverable
  #
  # Defines which key will be used when recovering the password for an account
  config.reset_password_keys = DEVISE_CONFIG['reset_password_keys'].map! {|i| i.to_sym}

  # Time interval you can reset your password with a reset password key.
  # Don't put a too small interval or your users won't have the time to
  # change their passwords.
  config.reset_password_within = eval DEVISE_CONFIG['reset_password_within']

  # ==> Configuration for :encryptable
  # Allow you to use another encryption algorithm besides bcrypt (default). You can use
  # :sha1, :sha512 or encryptors from others authentication tools as :clearance_sha1,
  # :authlogic_sha512 (then you should set stretches above to 20 for default behavior)
  # and :restful_authentication_sha1 (then you should set stretches to 10, and copy
  # REST_AUTH_SITE_KEY to pepper)
  config.encryptor = DEVISE_CONFIG['encryptor'].to_sym

  # ==> Configuration for :token_authenticatable
  # Defines name of the authentication token params key
  config.token_authentication_key = DEVISE_CONFIG['token_authentication_key'].to_sym

  # If true, authentication through token does not store user in session and needs
  # to be supplied on each request. Useful if you are using the token as API token.
  config.stateless_token = DEVISE_CONFIG['stateless_token']

  # ==> Scopes configuration
  # Turn scoped views on. Before rendering "sessions/new", it will first check for
  # "users/sessions/new". It's turned off by default because it's slower if you
  # are using only default views.
  config.scoped_views = DEVISE_CONFIG['scoped_views']

  # Configure the default scope given to Warden. By default it's the first
  # devise role declared in your routes (usually :user).
  config.default_scope = DEVISE_CONFIG['default_scope'].to_sym

  # Configure sign_out behavior.
  # Sign_out action can be scoped (i.e. /users/sign_out affects only :user scope).
  # The default is true, which means any logout action will sign out all active scopes.
  config.sign_out_all_scopes = DEVISE_CONFIG['sign_out_all_scopes']

  # ==> Navigation configuration
  # Lists the formats that should be treated as navigational. Formats like
  # :html, should redirect to the sign in page when the user does not have
  # access, but formats like :xml or :json, should return 401.
  #
  # If you have any extra navigational formats, like :iphone or :mobile, you
  # should add them to the navigational formats lists.
  #
  # The :"*/*" and "*/*" formats below is required to match Internet
  # Explorer requests.
  config.navigational_formats = DEVISE_CONFIG['navigational_formats'].map! {|i| eval i}

  # The default HTTP method used to sign out a resource. Default is :delete.
  config.sign_out_via = DEVISE_CONFIG['sign_out_via'].to_sym

  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'

  # ==> Warden configuration
  # If you want to use other strategies, that are not supported by Devise, or
  # change the failure app, you can configure them inside the config.warden block.
  #
  # config.warden do |manager|
  #   manager.failure_app   = AnotherApp
  #   manager.intercept_401 = false
  #   manager.default_strategies(:scope => :user).unshift :some_external_strategy
  # end
end
