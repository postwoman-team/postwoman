class Env
  @@workbench = {}
  @@requests = []

  def self.requests
    @@requests
  end

  def self.workbench
    @@workbench
  end

  def self.config
    return @config if @config

    default_config = YAML.load_file('utils/default_config.yml')
    user_config = File.exist?('config.yml') ? YAML.load_file('config.yml') : {}
    merger = proc do |_key, default_value, user_value|
      default_value.is_a?(Hash) && user_value.is_a?(Hash) ? default_value.merge(user_value, &merger) : user_value
    end

    @config = default_config.merge(user_config, &merger)
    @config
  end
end
