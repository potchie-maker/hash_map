require_relative 'lib/hash_map'
require_relative 'lib/linked_lists'
require_relative 'lib/hash_set'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

# test.buckets.each { |bucket| p bucket.head}

# p test.entries

# p test.capacity

# test.buckets.each { |bucket| p bucket.head}