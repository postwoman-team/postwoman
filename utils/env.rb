class Env
  @@workbench = {}
  @@requests = []

  def self.requests
    @@requests
  end

  def self.last_request 
    @@requests.last
  end

  def self.no_requests?
    @@requests.empty?
  end

  def self.workbench
    @@workbench
  end
end
