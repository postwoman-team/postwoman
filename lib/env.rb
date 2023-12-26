module Env
  DOTFILE_PATH = File.join(Dir.home, '.postwoman')
  CONFIG_PATH = File.join(DOTFILE_PATH, 'config.yml')

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

  def config
    return @config if @config

    default_config = YAML.load_file(src_dir('default_config.yml'))
    unless File.exist?(CONFIG_PATH)
      FileUtils.mkdir_p(DOTFILE_PATH)
      File.write(CONFIG_PATH, YAML.dump({}))
    end

    user_config = YAML.load_file(CONFIG_PATH)

    merger = proc do |_key, default_value, user_value|
      default_value.is_a?(Hash) && user_value.is_a?(Hash) ? default_value.merge(user_value, &merger) : user_value
    end

    @config = default_config.merge(user_config, &merger)
    @config
  end
end
