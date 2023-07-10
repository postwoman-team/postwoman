class Autocompletion
  def self.generate_proc
    loader_names = (Loaders.constants - [:Builtin]).map do |name|
      camelcase(name.to_s)
    end

    proc do |str|
      completions = []
      loader_names.each do |name|
        next if name == str
        if name.start_with?(str)
          completions << name
        end
      end
      completions.sort
    end
  end

  def self.camelcase(string)
    string.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end
