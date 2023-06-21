  # frozen_string_literal: true

  $LOAD_PATH.push File.expand_path("lib", __dir__)

  require "emails/version"

  Gem::Specification.new do |spec|
    spec.name        = "emails"
    spec.version     = Emails::VERSION
    spec.authors     = ["Developers"]
    spec.email       = ["engineering@rdstation.com"]
    spec.summary     = "Emails component"
    spec.description = "The components serve emails feature"

    spec.files = Dir["{app,config,db,spec}/**/*"]
  end
