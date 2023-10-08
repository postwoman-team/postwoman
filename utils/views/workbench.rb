module Views
  module_function

  def workbench
    return Style.apply('Currently empty') if Env.workbench.empty?

    workbench_table = Env.workbench.to_a.map do |(k, v)|
      case v
      when NilClass
        v = 'null'
      when String
        v = "\"#{v.to_s.yellow}\""
      end
      [k, v]
    end

    Style.table(workbench_table)
  end
end
