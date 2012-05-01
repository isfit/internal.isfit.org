# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false

# Initialize the rails application
InternalIsfitOrg::Application.initialize!

Mime::Type.register "application/vcard", :vcf
