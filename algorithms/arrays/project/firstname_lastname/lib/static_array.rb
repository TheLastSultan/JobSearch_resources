# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
  end

  # O(1)
  def [](index)
  end

  # O(1)
  def []=(index, value)
  end

  protected
  attr_accessor :store
end
