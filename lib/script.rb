module Script
  module_function

  def exist?(name)
    names.include? name
  end

  def names
    return [] unless Dir.exist?('scripts')

    Dir.glob('scripts/*.rb').map { |file| File.basename(file, '.rb') }
  end
end
