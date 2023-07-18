def fetch_loader_names
  (Loaders.constants - %i[Builtin Utils]).map(&:to_s)
end
