Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Settings.google_api.client_id,
           Settings.google_api.client_secret,
           scope: Settings.google_api.scope,
           skip_jwt: true
end
