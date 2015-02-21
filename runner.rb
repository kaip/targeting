require 'json'
require_relative 'expression_evaluator'

data = JSON.parse(ARGV.first)
expression = ARGV.last
puts ExpressionEvaluator.new(data, expression).data_matches_expression?