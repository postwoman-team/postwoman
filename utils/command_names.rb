def fetch_command_names
  (Commands.constants - [:Base]).map(&:to_s)
end
