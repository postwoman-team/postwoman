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
    user_config = File.exist?('config') ? YAML.load_file('config.yml') : {}
    @config = default_config.merge(user_config)
    @config
  end
end
