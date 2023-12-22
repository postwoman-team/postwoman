module Package
  YML_FILENAME = 'postwoman_package.yml'.freeze
  NEEDED_PATHS = {
    'loaders/base.rb' => 'templates/loader_base.rb'
  }.freeze

  module_function

  def load(path, create_flag: false)
    create(path) if create_flag
    return puts Views::Package.invalid(path) unless exist?(path)

    Dir.chdir(path)

    NEEDED_PATHS.each do |needed_path, template_path|
      next if File.exist?(needed_path)

      FileUtils.mkdir_p(
        Pathname.new(needed_path).dirname.to_s
      )
      File.write(needed_path, File.read(Env.src_dir(template_path)))
      puts Views::Package.creating_missing_file(needed_path)
    end

    true
  end

  def exist?(path)
    File.exist?("#{path}/#{YML_FILENAME}")
  end

  def create(path)
    return puts Views::Package.already_exists(path) if exist?(path)

    puts Views::Package.creating_new(path)

    FileUtils.mkdir_p(path)
    specifications = {
      name: Pathname.new(path).realpath.basename.to_s,
      description: nil,
      version: nil
    }
    File.write("#{path}/#{YML_FILENAME}", YAML.dump(specifications))
  end

  def metainfo(key)
    @metainfo ||= YAML.load_file(YML_FILENAME)
    @metainfo[key]
  end
end
