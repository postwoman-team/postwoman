def fetch_command_names
  (Commands.constants - [:Base]).map(&:to_s)
end

def fetch_loader_names
  (Loaders.constants - %i[Builtin Utils]).map(&:to_s)
end
