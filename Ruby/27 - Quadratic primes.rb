=begin
Euler discovered the remarkable quadratic formula:

n**2+n+41
It turns out that the formula will produce 40 primes for the consecutive integer values 0≤n≤39. However, when n=40, 40**2+40+41=40(40+1)+41 is divisible by 41, and certainly when n=41, 41**2+41+41 is clearly divisible by 41.

The incredible formula n**2−79n+1601 was discovered, which produces 80 primes for the consecutive values 0≤n≤79. The product of the coefficients, −79 and 1601, is −126479.

Considering quadratics of the form:

n**2+an+b, where |a|<1000 and |b|≤1000

where |n| is the modulus/absolute value of nn
e.g. |11|=11 and |−4|=4
Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n=0.
=end
#######################################################################################


require "prime"

def quadratic_primes(max_coefficient) # max_coefficient is 1000 for this Euler problem

	# per rules, |a| < 1000
	a_vals = (-(max_coefficient - 1)...max_coefficient).to_a

	b_vals = []
	# b_vals will need to between (inclusive) -1000 and 1000, per rules
	# only prime b values will return a prime number when n=0
	# since every set of ns starts with n=0, we need no b values other than primes

	# push all primes and their negatives 0..1000 into b_vals
	Prime.each do |prime|
		break if prime > max_coefficient
		b_vals << [prime, -prime]
	end

	b_vals.flatten! #flat array of all potentially useful b values

	find_longest_run_product(a_vals, b_vals)
end

def find_longest_run_product(a_vals, b_vals)
	# value to keep track of longest run of consecutive ns
	longest_run = 0

	# value to keep track of product of coefficients at last longest run
	latest_result = 0

	# check each combination of a and b
	a_vals.each do |a|
		b_vals.each do |b|
			n = 0
			# find how many consecutive values of n return a prime with current a and b
			while quadratic_is_prime?(n, a, b)
				n += 1
			end

			# store length of run and prospective result if run is the longest yet seen
			if n - 1 > longest_run
				longest_run = n - 1
				latest_result = a * b
			end
		end
	end

	latest_result
end

def quadratic_is_prime?(n, a, b)
	(n ** 2 + a * n + b).prime?
end

p quadratic_primes(1000) #=> -59231
