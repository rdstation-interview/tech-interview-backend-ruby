  module Emails
    class Engine < ::Rails::Engine
      config.generators do |g|
        g.test_framework :rspec
      end

      config.autoload_paths << File.expand_path('lib', __dir__)
    end
  end
