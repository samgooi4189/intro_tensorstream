require 'tensor_stream'

ts = TensorStream

w1 = ts.variable(2, name: "scalar1")
m1 = ts.variable([[1,2], [3,4]], name: 'matrix1')
# create matrix with 784 rows and 10 columns
W1 = ts.variable(ts.zeros([784, 10]))
puts "#{W1.shape}" 

s2 = ts.get_variable("scalar2", initializer: ts.constant(2)) 
m2 = ts.get_variable("matrix2", initializer: ts.constant([[0, 1], [2, 3]]))
W2 = ts.get_variable("weight_matrix2", shape: [784, 10], initializer: ts.zeros_initializer)
puts "#{W2.shape}"


session = ts.session
a = ts.get_variable("var_1", initializer: ts.constant(2))
b = ts.get_variable("var_2", initializer: ts.constant(3))
c = ts.add(a, b, name: "Add1")

# Running directly will throw uninitialized exception
# session.run(a)
# session.run(b)
# session.run(c)

# To Fix
init_op = ts.global_variables_initializer
session.run(init_op)
puts "var_1 #{session.run(a)}"
puts "var_2 #{session.run(b)}"
puts "Add_1 #{session.run(c)}"




# create weight and bias matrices
weights = ts.get_variable(name: "W", shape: [2,3], initializer: ts.truncated_normal(stddev: 0.01))
biases = ts.get_variable(name: "b", shape: [3,1], initializer: ts.zeros_initializer())

# add an Op to initialize global variables
init_op = ts.global_variables_initializer()
#require 'byebug'
#byebug
#ts.session.run(init_op)
W, b = ts.session.run([weights, biases])
puts "\nweights = #{W}"
puts "\nbiases = #{b}"

