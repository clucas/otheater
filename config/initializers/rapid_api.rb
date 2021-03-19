module RapidApi
  CONFIG = YAML.load_file(
      File.join(Rails.root, 'config', 'rapid_api.yml')) [Rails.env].deep_symbolize_keys
end