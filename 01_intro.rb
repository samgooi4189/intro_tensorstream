require 'tensor_stream'

ts = TensorStream

#w = ts.variable(0, name: 'weights') # not allow duplicated tensor
#c = ts.constant(1.0)

# calling .t on Integer,Array and Float types will converts it to a tensor
w = 0.t.var name: 'weights'
c = 1.0.t



x = ts.placeholder(:float32, shape: [1024, 1024])
y = ts.placeholder(:float32, shape: [nil, 1024])

# Another a bit more terse way
x = Float.placeholder shape: [1024, 1024]
y = Float.placeholder shape: [nil, 1024]




# For debugging
X = ts.placeholder("float")
Y = ts.placeholder("float")
W = ts.variable(rand, name: "weight")
b = ts.variable(rand, name: "bias")
pred = X * W + b
cost = ts.reduce_sum(ts.pow(pred - Y, 2)) / (2 * 10)
puts cost.to_math # "(reduce_sum(|((((Placeholder: * weight) + bias) - Placeholder_2:)^2)|) / 20.0)"

# breakpoint
# https://github.com/jedld/tensor_stream/issues/5
a = ts.constant([[2,2]])
b = ts.constant([[3],[3]])
f = ts.matmul(a,b).breakpoint! { |tensor, a, b, result_value| binding.pry }

ts.session.run(f)

