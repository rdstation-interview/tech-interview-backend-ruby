require 'microservice_toolkit'
Microservice::Toolkit::HealthCheck.configure do |config|
config.use :active_record
end
