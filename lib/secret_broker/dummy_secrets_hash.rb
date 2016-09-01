class SecretBroker
  class DummySecretsHash
    def fetch(key)
      "SECRET VALUE FOR #{key} REQUESTED FOR AN ENVIRONMENT OTHER THAN THE CURRENT ENVIRONMENT"
    end
  end
end
