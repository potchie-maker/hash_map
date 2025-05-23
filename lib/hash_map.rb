require_relative 'linked_lists'

class HashMap
  attr_accessor :buckets
  attr_reader :capacity
  
  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    @buckets = Array.new(@capacity) { LinkedList.new }
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def capacity
    @capacity
  end

  def rehash
    return unless self.length >= (@capacity * @load_factor)
    old_entries = self.entries
    @capacity *= 2
    @buckets = Array.new(@capacity) { LinkedList.new }

    old_entries.each do |key, value|
      self.set(key, value)
    end
  end

  def set(key, value)
    self.rehash
    hash_code = hash(key)
    index = hash_code % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    bucket = @buckets[index]
    existing_node = bucket.find_node(key)
    if existing_node
      existing_node.value = value
    else
      bucket.append(key, value)
      @size += 1
    end
  end

  def get(key)
    hash_code = hash(key)
    index = hash_code % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    node = @buckets[index].find_node(key)
    node&.value
  end

  def has?(key)
    hash_code = hash(key)
    index = hash_code % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    @buckets[index].contains?(key)
  end

  def remove(key)
    hash_code = hash(key)
    index = hash_code % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    removed = @buckets[index].delete(key)
    @size -= 1 if removed
    removed
  end

  def occupancy
    count = 0
    @buckets.each do |bucket|
      count += 1 unless bucket.head == nil
    end
    count
  end

  def length
    @size
  end

  def clear
    @buckets.each do |bucket|
      bucket.head = nil
      bucket.tail = nil
    end
    @size = 0
  end

  def keys
    list = []
    @buckets.each do |bucket|
      list.concat(bucket.list_keys)
    end
    list
  end

  def values
    list = []
    @buckets.each do |bucket|
      list.concat(bucket.list_values)
    end
    list
  end

  def entries
    list = []
    @buckets.each do |bucket|
      list.concat(bucket.list_pairs)
    end
    list
  end
end