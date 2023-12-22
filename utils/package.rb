module Package
  YML_FILENAME = 'postwoman_package.yml'.freeze

  module_function

  def create(path)
    FileUtils.mkdir_p(path)
    Dir.mkdir("#{path}/loaders")
    specifications = {
      name: Pathname.new(path).realpath.basename.to_s,
      description: nil,
      version: nil
    }
    File.write("#{path}/#{YML_FILENAME}", YAML.dump(specifications))
  end

  def valid?(path)
    File.exist?("#{path}/#{YML_FILENAME}") && Dir.exist?(path)
  end

  def metainfo(key)
    @metainfo ||= YAML.load_file(YML_FILENAME)
    @metainfo[key]
  end
end
