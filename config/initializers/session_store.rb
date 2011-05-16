# Be sure to restart your server when you modify this file.

Titleloans::Application.config.session_store :cookie_store, :key => '_titleloans_session'

Rails.application.config.middleware.insert_before(
  ActionDispatch::Session::CookieStore,
  FlashSessionCookieMiddleware,
  Rails.application.config.session_options[:key]
)

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Titleloans::Application.config.session_store :active_record_store
