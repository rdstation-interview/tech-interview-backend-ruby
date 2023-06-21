require 'ddtrace'

Datadog.configure do |c|
  c.service = 'tech_interview_challenge'
  c.agent.host = ENV['DD_TRACE_AGENT_HOST']
  c.agent.port = ENV['DD_TRACE_AGENT_PORT']
  c.env        = Rails.env
  c.tags       = { env: Rails.env, app: 'tech_interview_challenge' }
end

