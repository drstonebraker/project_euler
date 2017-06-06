=begin
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
=end
#######################################################################################

# built-in approach
=begin
def sum_primes(max)
	require "prime"
	sum = 0

	Prime.each do |prime|
		break if prime >= max
		sum += prime
	end

	sum
end
=end

# pre-written approach
=begin
def sum_primes(max)
	require_relative "07 - 10001st prime"
	prime_sieve(max - 1).inject(:+)
end
=end

# prime_sieve modified to return sum instead of array
def sum_primes(limit)
	nums = (2...limit).to_a
	sqrt = Math.sqrt(limit)
	primes_sum = 0

	# once sqrt is passed, all multiples of remaining nums have already been rejected.
	until nums.first > sqrt
		# first num in list is guaranteed prime, as all multiples of previous primes have been rejected
		prime = nums.shift
		primes_sum += prime

		# delete every multiple of the most recent prime
		index = prime
		while index < limit
			nums[index - 1] = nil
			index += prime
		end

		# find next non-rejected num
		nums.shift while nums[0].nil?
	end

	# primes_sum is now sum of all prime numbers <= sqrt
	# nums is now filtered list of all primes between sqrt and limit
	primes_sum + nums.compact.inject(:+)
end



p sum_primes(2_000_000) #=> 142913828922
