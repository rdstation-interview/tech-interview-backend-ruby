# frozen_string_literal: true

namespace :rspec do
  task :verify_install do
    if File.exist?('.rspec')
      exit
    end
    abort
  end
end
