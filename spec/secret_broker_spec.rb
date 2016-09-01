require 'spec_helper'

describe SecretBroker do
  it 'has a version number' do
    expect(SecretBroker::VERSION).not_to be nil
  end

  describe 'environment methods' do
    before do
      allow(Rails).to receive(:env).and_return 'production'
    end

    context 'method called is current env' do
      specify do
        secret_value = SecureRandom.uuid
        allow(described_class).to receive(:ejson_secrets_file).and_return(instance_double(described_class::EJsonSecretsFile, to_h: { my_secret: secret_value }))
        expect(described_class.production.fetch(:my_secret)).to eq secret_value
      end
    end

    context 'method called is not current env' do
      specify do
        expect(described_class.staging.fetch(:my_secret)).to eq 'SECRET VALUE FOR my_secret REQUESTED FOR AN ENVIRONMENT OTHER THAN THE CURRENT ENVIRONMENT'
      end
    end
  end
end
