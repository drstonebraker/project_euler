=begin
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

What is the 10 001st prime number?
=end
#######################################################################################

# built-in approach:
=begin
def find_nth_prime(n)
	require "prime"
	Prime.first(n).last
end
=end

# naive approach (written before learning of Sieve of Eratosthenes):
=begin
def find_nth_prime(n)
	# list of prime numbers
	primes = []
	# counts how many primes we have
	count = 0
	# stores last value of prime
	prime = 0

	# check each positive integer for possible prime
	(2..Float::INFINITY).each do |num|
		# if no factor found, num is prime. push to primes and increment count
		unless primes.find{|factor| num % factor == 0}
			prime = num
			primes << prime
			count += 1
		end
		# if count == n, we've found the nth prime
		break if count == n
	end

	prime
end
=end

# efficient method:
def find_nth_prime(n)
	# handle input of 1 or 2
	return n + 1 if n <= 2
	# nth prime is approximate equal to n * log(n) according to prime number theorem.
	# I'm using log2 instead of natural log, to overshoot the limit a bit
	limit = (n * Math.log2(n)).to_i

	#get list of primes less than limit
	primes = prime_sieve(limit)

	if primes.length >= n # if list includes nth prime, return it
		return primes[n-1]
	else # else increase limit a bit and try again
		limit = (n * (Math.log2(n) + Math.log2(Math.log2(n)))).to_i
		return prime_sieve(limit)[n-1]
	end
end

# this helper method returns an array of all prime numbers less than limit using the sieve of eratosthenes algorithm
def prime_sieve(limit)
	nums = (2..limit).to_a
	sqrt = Math.sqrt(limit)
	primes = []

	# once sqrt is passed, all multiples of remaining nums have already been rejected.
	until nums.first > sqrt
		# first num in list is guaranteed prime, as all multiples of previous primes have been rejected
		prime = nums.shift
		primes << prime

		# delete every multiple of the most recent prime
		index = prime
		while index < limit
			nums[index - 1] = nil
			index += prime
		end

		# find next non-rejected num
		nums.shift while nums[0].nil?
	end

	# primes is now all prime numbers <= sqrt
	# nums is now filtered list of all primes between sqrt and limit
	primes + nums.compact
end

p find_nth_prime(10_001) #=> 104743
