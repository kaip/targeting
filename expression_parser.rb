require_relative 'nodes'

class ExpressionParser
  def initialize(expression)
    @expression = expression
  end

  def parse(expression = nil)
    expression ||= @expression
    root = expression.keys.first
    if %w(and or not).include?(root)
      # AndNode, OrNode, NotNode
      expressions = expression.values.first.map do |expression|
        ExpressionParser.new(expression).parse
      end
      Object::const_get("#{root.capitalize}Node").new(expressions)
    else
      EqualityNode.new(*expression.to_a.first)
    end
  end
end