def fetch_loader_names
  (Loaders.constants - [:Builtin, :Utils]).map(&:to_s)
end
