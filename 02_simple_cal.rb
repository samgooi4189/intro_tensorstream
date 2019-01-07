require 'tensor_stream'

ts = TensorStream
s = ts.session

# eager_execution doesn't do much for now, onlt disallow placeholder
# ts.enable_eager_execution

f = ts.add(1,2)
puts s.run(f)

f = ts.subtract(4,2)
puts s.run(f)

f = ts.multiply(1,3)
puts s.run(f)

f = ts.div(6,3)
puts s.run(f)

s.close
