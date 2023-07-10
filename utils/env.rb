class Env
  @@workbench = {}
  @@requests = []

  def self.requests
    @@requests
  end

  def self.workbench
    @@workbench
  end
end
