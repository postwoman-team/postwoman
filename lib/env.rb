module Env
  DOTFILE_FOLDER = '.postwoman'.freeze
  CONFIG_FILE = 'config.yml'.freeze

  module_function

  def requests
    @requests ||= []
  end

  def workbench
    @workbench ||= {}
  end

  def src_dir(path)
    "#{__dir__}/#{path}"
  end

  def refresh_config
    @config = nil
    Env.config
  end

  def dotfile_path
    File.join(Dir.home, DOTFILE_FOLDER)
  end

  def config_path
    File.join(dotfile_path, CONFIG_FILE)
  end

  def config
    return @config if @config

    @default_config ||= YAML.load_file(src_dir('default_config.yml'))

    unless File.exist?(config_path)
      FileUtils.mkdir_p(dotfile_path)
      File.write(config_path, YAML.dump({}))
    end

    user_config = YAML.load_file(config_path)

    merger = proc do |_key, default_value, user_value|
      default_value.is_a?(Hash) && user_value.is_a?(Hash) ? default_value.merge(user_value, &merger) : user_value
    end

    @config = @default_config.merge(user_config, &merger)
    @config
  end
end
