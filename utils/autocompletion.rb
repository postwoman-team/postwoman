class Autocompletion
  def self.generate_proc
    proc do |str|
      loader_names = (Loaders.constants - [:Builtin, :Utils]).map do |name|
        camelcase(name.to_s)
      end

      completions = []
      loader_names.each do |name|
        next if name == str

        completions << name if name.start_with?(str)
      end
      completions.sort
    end
  end

  def self.camelcase(string)
    string.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr('-', '_')
          .downcase
  end
end
