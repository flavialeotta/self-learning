---
engine: markdown
---

# Lecture 1: Introduction to Deep Learning

Lecturer: Bartek Wilczyński

The **first part** of this lecture introduced some key concepts in Machine Learning. As I've already taken a course in it during my MSc, I didn't take any notes. However, the lecturer recommended the book "An Introduction to Statistical Learning" which is the same book I used to prepare myself for my ML exam: it is a wonderful book that explains all key concepts in a very simple and clear way and, very importantly, available [online for free](https://www.statlearning.com/).

The **second part** of the lecture gave a summary of the story of Neural Networks. It is interesting but, again, I didn't take notes. Please refer to the [lecture materials](https://github.com/deeplife4eu/Lecture-materials/blob/main/Week_01/DeepLife-1-Intro.pdf).

## Modern Deep Learning

In the **third part** of the lecture, we dived into how modern NN models are built and trained. I have learnt that any network consisting of at least three layers (i.e. 2 stacked layers of perceptrons) can be considered "deep" neural networks.

<img src="https://c.mql5.com/18/20/NN1__1.gif" width="400"/>

Now, let's pretend we have a neural network with three layers: there are inputs $x$, then an hidden layer with a weight $w_{1}$ and a bias $b_{1}$. The final layer is the output, this one has also a weight $w_{2}$ and a bias $b_{2}$. Training the neural network happens in 3 steps:

1. **Inizializing**: weights are usually inizialized randomly, while biases are usually set as 0 or very small numbers.
2. **Forward pass**:
   - inputs ($$x_{i}$$) enter the input layer and then are multiplied for a certain weight ($$w_{i,1}$$) when entering the first layer of "neurons". Each neuron receives all inputs, each multiplied for a different weight which is specific not only for the input provided, but for the neuron that received them too;
   - after all inputs, multiplied for their weights, reach a neuron, they are summed with each other and also by a certain amount of bias, specific of the neuron ($b_{1}$). We will call the sum of all the weighted inputs and biases for the first neuron $z_{1}$:

     $$z_{1} = w_{i,1}x_{i} + w_{j,1}x{j}+...+b_{1}$$
     
   - Before passing the value $z_{1}$ it down, the neuron needs to be "activated". That means that, if this value $z_{1}$, transformed into $a_{1}$ using a certain "activation function", doesn't reach a certain threshold, then the neuron remains inactive and the new input is not passed down.

      > **Activation functions**: there are different activation functions, but the most used is the ReLU. We will see why.
      > 
      > $$sigmoid: \space \sigma(z)=\frac{1}{1+e^{-x}} \quad \quad tanh: \space tahn(x) \quad \quad ReLU: \space max(0,x)$$
   - We can pretend, in this example, that the activation function is the sigmoid. $z_{1}$ is transformed into $a_{1} = \frac{1}{1+e^{-z_{1}}}$. If $a_{1}$ reaches a certain threshold, the input passes to the second layer of neurons (in this case, also the output layer). We do the same thing again: we first sum the inputs $z_{2} = w_{i,2}a_{i} + w_{j,2}a{j}+...+b_{2}$, then we transform the output $a_{2} = \frac{1}{1+e^{-z_{2}}}$ and, if this reaches the set treshold, it will be out final output (prediction).
3. **Backpropagation**:
   - Now we want to assess the performance of the model. During training, if the result $a_{2}$ obtained is wrong, we need to correct the weights. How is "wrong" defined? Like in logistic regression, the error is calculated as a [Log-Loss](#log-loss) function. It is calculated at the very last layer (outputs), by comparing the predicted result ($a_{2}$) with the real output we were expecting ($y$):

     $$LogLoss = -\[y \log(a_{2}) + (1-y)log(1-a_{2})\]$$

     Remember, we usually want to optimize a model, which means to minimize a *Loss* function. In simple terms? We want the Log-Loss to be as close to 0 as possible!
   - We first calculate the partial derivate of the error (Log-loss) with respect to the weighted sum ($z_{2}$), the one that allowed us to calculate the output $a_{2}$. Because we used the sygmoid (very easy to derivate), the formula can be simplified:
     
     $$\frac{\delta LogLoss}{\delta {z_{2}}} = a_{2} - y$$
     
   - Following the **chain rule**, the impact that the weight had on the error when we calculated $z_{2}$ is calculated as:

     $$\frac{\delta LogLoss}{w_{2}} = \frac{\delta LogLoss}{\delta {z_{2}}} \cdot \frac{\delta z_{2}}{\delta w_{2}}$$

     Because $z_{2} = w_{2} \cdot a_{1}$  the formula can be simplified to $\frac{\delta Log-loss}{w_{2}} = (a_{2} - y) \cdot a_{2}$.
   - The weights are updated using the **learning rate** ($\eta$):

     $$w_{2, new} = w_{2, old} - \eta \cdot \frac{\delta \text{LogLoss}}{\delta w_{2}}$$
   - The chain rule allows the error to go back even to the first layer, to correct $w_{1}$ too:

     $$\frac{LogLoss}{w_{1}} = \frac{LogLoss}{z_{2}} \cdot \frac{z_2}{a_1} \cdot \frac{a_1}{z_1} \cdot \frac{z_1}{w_1}$$

     > **What about biases?**: they are updated in the same manner!
     
These steps are repeated many times, in what we call a *learning loop*. The simples method is to take the lopp over all observations (an epoch) and adapt the weight accordin to the gradient function with a learning rate. If we do this in random order in each epoch, this is a variant of *Stochastic Gradient Descent*. Usually many learning epochs are needed to reach convergence. 

## Adaptive optimizers momentum and ADAM

The problem is that some weights have similar gradients while others are oscillating, and it can make it hard to reach the minimum, caused by two main problems:

1. the gradient can be "pulled" by some weights in the opposite direction than the global minimum (towards a local minimum "preferred" by one of the gradients);
2. by having only one learning rate, we could be either go too fast or too slow, because some gradients might need a bigger or smaller step than others.

The **momentum** algorithm adds a rescaled gradient from the previous step to the current gradient, so learning can be faster when gradients are consistent and slower if we start oscillating.

ADAM (ADAptive Momentum estimation) adds another idea: by looking at the first and second [moments](#moments) of the gradient, and adding "forgetting" factors $\beta_1$ and $\beta_2$ to the estimation process:

- First, it computes the first moment: $m_t = \beta_1 \cdot m_{t-1} + (1-\beta_1) \cdot g_t$;
- then it computes the second moment: $v_t = \beta_2 \cdot v_{t-1} + (1-\beta_2) \cdot g_t^2$;
- both are applied to the weights update: $w_{new} = w_{old} - \frac{\eta}{\sqrt{v_t}+\epsilon}\cdot m_t$.

## Regularization: dilution and dropout

Deep learning is prone to overfitting: you could use techniques that are used in standard ML (Lasso and Ridge), but the most popular regularization techniques are based on randomized removal of subsets of weights during training. In case of **dilution**, during each training epoch a random subset of weights is not updated. In the case of **dropout**, all weights associated to a subset of neurons will not be used at all. These techniques slow don the process of training but they make the model better.

And, for today, we have finished! See you on the practical part.


<img src="https://gifdb.com/images/high/happy-cat-working-on-computer-cartoon-c2cinzv2rijwf3en.gif" width="500"/>

--------
## Refreshers

### **Log Loss**
As a refresher, the Log-Loss is a function that allows us to maximilize the Likelihood of the data. Said like this, it can sound confusing, but it is not that complicated. Let's just say that, the probability to observe the true output $y$, given the computed/predicted output $\hat{y}$ is:

$$ P(y|\hat{y}) = \hat{y}^{y} \cdot (1-\hat{y})^{(1-y)}$$

This is simply a Bernoulli distribution (the output is either 1 or 0). But we don't have only one input nor neuron (which would mean only one weight to optimize), but a whole set, and we want to maximize the probability of observing the "true output" for the entire dataset, not only one neuron. When we talk about Maximum Likelihood, we mean that we want to maximize how close our neural network can model the **entire** dataset (Likelihood of data). Following Probability theory, the probability that **ALL** the observations are correct, is the multiplication of each **single** observation. Problem: if we multiply many numbers smaller than 1, we obtain a very little number, so we apply a logarythm to have a number that is a little more readable by a human. Finally, since optimization algorythms are made to minimize error functions, we add a negative sign in front of the formula:

$$ Log Loss = - \[ y \cdot \log{\hat{y}} + (1-y) \cdot \log(1-\hat{y}) \]$$
      
### Moments
In this case, moments are simply the mean and the variance of gradients in time:

- The first moment registers the average direction towards which a gradient is moving.
- The second moment registers the "variance" of the gradients, which is how much the gradients change at each step.

These concepts come from linear algebra. It might be a little bit of an overkill to explain here, but in synthesis in linear algebra, when you want to decompose (find out its components) a complex vector, you project it onto a basis (i.e. usually the axes x, y, z, but you can take anything else as a reference). To understand the components of a vector, in linear algebra you do the **Inner/Scalar product** $\langle U | V \rangle = \sum{U_i \cdot V_i}$ between the vector and the basis (ex: to find out the coordinate $x$ of a vector $v$ you do $v_1x_1 + v_2x_2 + v_3x_3$, which will give you a single number).

In Machine Learning data is not certain, our observations follow a certain probability distribution. The moments are the projections (scalar products) of the probabilities distributions on your basis. If you project your observations $x$ and their probabilities $p$ on a linear basis ($x^1$) you obtain: $\langle X | P \rangle = \sum{x_i \cdot p_i} = \mathbb{E}\[X\]$. This is both the first moment and the average. If, instead, you project your observations $x$ and their probabilities $p$ on a quadratic basis ($x^2$) you obtain the variance $\mathbb{E}\[X^2\]$.

      
