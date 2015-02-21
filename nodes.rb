class LeafNode
  def initialize(hash)
    @key = hash.keys.first
    @value = hash.values.first
  end

  def evaluate(data)
    raise NotImplementedError
  end
end

class EqualityNode < LeafNode
  def evaluate(data)
    data[@key] == @value
  end
end

class GreaterThanNode < LeafNode
  def evaluate(data)
    data[@key] > @value
  end
end

class LessThanNode < LeafNode
  def evaluate(data)
    data[@key] < @value
  end
end

class NonLeafNode
  def initialize(child_nodes)
    @child_nodes = child_nodes
  end

  def evaluate(data)
    raise NotImplementedError
  end
end

class AndNode < NonLeafNode
  def evaluate(data)
    @child_nodes.all? {|node| node.evaluate(data) }
  end
end

class OrNode < NonLeafNode
  def evaluate(data)
    @child_nodes.any? {|node| node.evaluate(data) }
  end
end

class NotNode < NonLeafNode
  def evaluate(data)
    !@child_nodes.first.evaluate(data)
  end
end

