es_config = YAML.load_file(File.join(Rails.root, "config", "elasticsearch.yml"))
config = es_config[Rails.env]

Tire::Model::Search.index_prefix config["index_prefix"]

Tire.configure do
  if config["log"]
    logger File.expand_path(config["log"], Rails.root)
  end
end
