DB_TRANSACTION = YAML::load(ERB.new(File.read(Rails.root.join("config","database_transaction.yml"))).result)[Rails.env]
