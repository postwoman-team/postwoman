module ArgsHandler
  def self.parse(raw)
    parser_obj = Parser.new(raw)
    Args.new(
      parser_obj.positionals,
      parser_obj.pairs,
      parser_obj.flags
    )
  end
end
