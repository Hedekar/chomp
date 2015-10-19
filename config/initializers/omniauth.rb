OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '439480046628-24g1o41nn67g2ra2mo4j84vrkkn6tss5.apps.googleusercontent.com', '5tA21bMmtvPgvE21qMZITjff', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
