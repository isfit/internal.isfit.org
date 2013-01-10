# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

# https://groups.google.com/forum/#!topic/rubyonrails-security/61bkgvnSGTQ/discussion
ActionDispatch::ParamsParser::DEFAULT_PARSERS.delete(Mime::XML)
