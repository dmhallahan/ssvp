# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ssvp_session',
  :secret      => 'ba56b1fbb749c2bb0af2171bf9ce47468dec6c07ac8edb251c33e1ca9fdc8f8cc5cd096e4739f5b76bdc2c9ecbaa0a7847eb59cc036d9adad81505240142f1e4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
