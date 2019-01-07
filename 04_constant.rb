require 'tensor_stream'

ts = TensorStream

a = ts.constant(2)
b = ts.constant(3)
c = a+b
puts "Simple sum is #{ts.session.run(c)}"


d = ts.constant(2, name: 'A')
e = ts.constant(2, name: 'B')
f = ts.add(d, e, name: "Sum")
puts "Sum is #{ts.session.run(f)}"


s = ts.constant(2.3, name: 'scalar', dtype: :float32)
m = ts.constant([[1,2], [3,4]], name: 'matrix')
session = ts.session
puts "scalar is #{session.run(s)}"
puts "matrix is #{session.run(m)}"
