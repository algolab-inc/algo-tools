class Provider < ActiveHash::Base
  self.data = [
    {
      id: 1,
      name: 'google',
      display_name: 'Google',
      auth_key: 'google_oauth2'
    }
  ]
end
