require 'json'
require 'open3'

class SecretBroker
  class EJsonSecretsFile
    def initialize(env)
      @env = env
    end

    def to_h
      return {} unless file_path.file?

      stdout_str, stderr_str, status = Open3.capture3 "ejson decrypt #{file_path.to_path}"
      fail "ejson decrypt did not run successfully. stderr: #{stderr_str}" unless status.success?

      JSON.parse stdout_str
    end

    private

    attr_reader :env

    def config_path
      Rails.root.join 'config', 'secrets'
    end

    def file_path
      config_path.join "#{env}.ejson"
    end
  end
end
