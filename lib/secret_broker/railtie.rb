class SecretBrokerRailtie < Rails::Railtie
  rake_tasks do
    load File.expand_path("../../tasks/secret_broker.tasks", __FILE__)
  end
end

