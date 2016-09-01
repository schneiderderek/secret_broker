require 'spec_helper'

RSpec.describe SecretBroker::DummySecretsHash do
  describe '#fetch' do
    specify do
      key = SecureRandom.uuid
      expect(subject.fetch(key)).to eq "SECRET VALUE FOR #{key} REQUESTED FOR AN ENVIRONMENT OTHER THAN THE CURRENT ENVIRONMENT"
    end
  end
end
