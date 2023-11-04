module Views
  module_function

  def workbench
    return Style.apply('<box>Currently empty</box>') if Env.workbench.empty?

    workbench_table = Env.workbench.to_a.map do |(k, v)|
      case v
      when NilClass
        v = 'nil'
      when String
        v = Style.apply("'<string>#{Style.protect(v.to_s)}</string>'")
      end

      [k.to_s, v.to_s]
    end

    Style.table(workbench_table)
  end
end
