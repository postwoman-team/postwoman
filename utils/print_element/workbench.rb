module PrintElement
  module_function

  def workbench
    return print_table('Currently empty') if Env.workbench.empty?

    print_hash(Env.workbench)
  end
end
