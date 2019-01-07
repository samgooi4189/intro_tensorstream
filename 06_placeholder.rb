require 'tensor_stream'

ts = TensorStream


a = ts.placeholder(:float32, shape: [5])
b = ts.placeholder(ts.float32, shape: nil, name: nil)
X = ts.placeholder(:float32, shape: [nil, 784], name: 'input')
Y = ts.placeholder(:float32, shape: [nil, 10], name: 'label')





a = ts.constant([5, 5, 5], dtype: ts.float32, name: 'A')
b = ts.placeholder(ts.float32, shape: [3], name: 'B')
c = ts.add(a, b, name: "Add")

# This will throw error on placeholder B
# ts.session.run(c) 

# need to pass b as place holder, not sym
d = { b => [1,2,3]}
puts "#{ts.session.run(c, feed_dict: d)}"



