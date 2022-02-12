RFC_DB = YAML.load_file(File.join(Rails.root, "config", "rfc_database.yml"))[Rails.env.to_s]
