require_relative 'nodes'

class ExpressionParser
  def initialize(expression)
    @expression = expression
  end

  def parse(expression = nil)
    expression ||= @expression
    root = expression.keys.first
    root_type = class_for(root)
    if root_type < LeafNode
      root_type.new(expression.values.first.first)
    else
      expressions = expression.values.first.map do |expression|
        ExpressionParser.new(expression).parse
      end
      root_type.new(expressions)
    end
  end

  private
  def class_for(root)
    {
      'and' => AndNode,
      'or' => OrNode,
      'not' => NotNode,
      '>' => GreaterThanNode,
      '<' => LessThanNode,
      '=' => EqualityNode
    }[root]
  end
end