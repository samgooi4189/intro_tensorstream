require 'tensor_stream'
ts = TensorStream
x = 2
y = 3
add_op = ts.add(x, y, name: 'Add')
mul_op = ts.multiply(x, y, name: 'Multiply')
pow_op = ts.pow(add_op, mul_op, name: 'Power')
useless_op = ts.multiply(x, add_op, name: 'Useless')

s = ts.session
pow_out, useless_out =  s.run([pow_op, useless_op])
puts "#{pow_out}, #{useless_out}"


