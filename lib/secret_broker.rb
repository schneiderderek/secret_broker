require 'secret_broker/dummy_secrets_hash'
require 'secret_broker/ejson_secrets_file'
require 'secret_broker/railtie'
require 'secret_broker/version'
require 'active_support/core_ext/hash/indifferent_access'


# SecretBroker class for accessing secrets stored using ejson.
#
# Usage:
#
# Secrets.environment.fetch :key
#
# Example (running in production):
#
# Secrets.production.database_password
# => 'pa$$w0rd'
#
# Secrets.staging.database_password
# => 'SECRET VALUE REQUESTED FOR database_password AN ENVIRONMENT OTHER THAN THE CURRENT ENVIRONMENT'
#
class SecretBroker
  class << self

    def current_environment_secrets
      @current_environment_secrets ||= HashWithIndifferentAccess.new(ejson_secrets_file.to_h)
    end

    def current_environment
      Rails.env
    end

    def ejson_secrets_file
      EJsonSecretsFile.new(current_environment)
    end

    REMOTE_ENVIRONMENTS = [:staging, :production].freeze

    REMOTE_ENVIRONMENTS.each do |environment_name|
      define_method environment_name do
        if environment_name.to_s == current_environment
          current_environment_secrets
        else
          DummySecretsHash.new
        end
      end
    end
  end
end
