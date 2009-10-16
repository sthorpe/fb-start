# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_connect_tutorial_session',
  :secret      => '6f095826c362c345113dfd75289242768e20c36584e338e684627820f22cdabcb13c6fb0d164bf4541fcbc2e1f9ff45d506913a139d20d11736fc76afc680ab6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
