# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_new_session',
  :secret      => '6118def370bd1690c6343a0311e44d8fa2e37885535d71edf52dceeefaec418043985d4f4891f89155b98524fa31c1b99e1ce45dcd8015c9aa51dcaadfa5e58a',
  :key => '_new_session',
  :expire_after=> nil
}
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
