require 'tensor_stream'

tf = TensorStream

learning_rate = 0.01
training_epochs = 1000
display_step = 50

train_X = [3.3,4.4,5.5,6.71,6.93,4.168,9.779,6.182,7.59,2.167,
7.042,10.791,5.313,7.997,5.654,9.27,3.1]
train_Y = [1.7,2.76,2.09,3.19,1.694,1.573,3.366,2.596,2.53,1.221,
2.827,3.465,1.65,2.904,2.42,2.94,1.3]

n_samples = train_X.size

# X = tf.placeholder("float")
X = Float.placeholder

# Y = tf.placeholder("float")
Y = Float.placeholder

# Set model weights
# W = tf.variable(rand, name: "weight")
W = rand.t.var name: "weight"

# b = tf.variable(rand, name: "bias")
b = rand.t.var name: "bias"

# Construct a linear model
pred = X * W + b

# Mean squared error
cost = ((pred - Y) ** 2).reduce / ( 2 * n_samples)

# optimizer = TensorStream::Train::MomentumOptimizer.new(learning_rate, momentum, use_nesterov: true).minimize(cost)
# optimizer = TensorStream::Train::AdamOptimizer.new(learning_rate).minimize(cost)
# optimizer = TensorStream::Train::AdadeltaOptimizer.new(1.0).minimize(cost)
# optimizer = TensorStream::Train::AdagradOptimizer.new(0.01).minimize(cost)
# optimizer = TensorStream::Train::RMSPropOptimizer.new(0.01, centered: true).minimize(cost)
optimizer = TensorStream::Train::GradientDescentOptimizer.new(learning_rate).minimize(cost)

# Initialize the variables (i.e. assign their default value)
init = tf.global_variables_initializer()

tf.session do |sess|
    start_time = Time.now
    sess.run(init)
    (0..training_epochs).each do |epoch|
      train_X.zip(train_Y).each do |x,y|
        sess.run(optimizer, feed_dict: {X => x, Y => y})
      end

      if (epoch+1) % display_step == 0
        c = sess.run(cost, feed_dict: { X => train_X, Y => train_Y })
        puts("Epoch:", '%04d' % (epoch+1), "cost=",  c, \
            "W=", sess.run(W), "b=", sess.run(b))
      end
    end

    puts("Optimization Finished!")
    training_cost = sess.run(cost, feed_dict: { X => train_X, Y => train_Y})
    puts("Training cost=", training_cost, "W=", sess.run(W), "b=", sess.run(b), '\n')
    puts("time elapsed ", Time.now.to_i - start_time.to_i)
end
