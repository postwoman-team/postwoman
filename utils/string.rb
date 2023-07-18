def snakecase(string)
  string.gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('-', '_')
        .downcase
end

def camelize(string)
  string.split('_').collect(&:capitalize).join
end
