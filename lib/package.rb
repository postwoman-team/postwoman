module Package
  YML_FILENAME = 'postwoman_package.yml'.freeze
  NEEDED_PATHS = {
    'loaders/base.rb' => 'templates/loader_base.rb'
  }.freeze

  module_function

  def load(input_path, create_flag: false) # rubocop:disable Metrics/MethodLength
    create(input_path) if create_flag

    path = nil

    if exist?(input_path)
      path = input_path
    elsif Dir.exist?(input_path)
      Pathname.new(input_path).realpath.ascend do |possible_path|
        if exist?(possible_path)
          path = possible_path
          break
        end
      end
    end

    return puts Views::Package.invalid(input_path) if path.nil?

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
