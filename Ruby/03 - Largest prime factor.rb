=begin
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
=end
#######################################################################################

# method returns largest prime factor of num
def largest_prime_factor(num_input)
	# copy input since num will be modified
	num = num_input
	# stores prime factors
	prime_factors = Hash.new

	# check each possible prime factor (other than num itself)
	(2..(num / 2)).each do |prime|
		# until every power of prime as been factored out of num
		until num % prime != 0
			prime_factors[prime] = true
			num /= prime
		end

		# break if all prime factors have been factored out of num
		break if num == 1
	end

	# if prime_factors is empty, then num is prime
	prime_factors.empty? ? num : prime_factors.keys.max
end

# The short method below gets the answer, but I also wrote a method without using the Prime class in case that's what you want to see
=begin
def largest_prime_factor(num)
	require "prime"
	num.prime_division.sort.last.first
end
=end

p largest_prime_factor(600851475143) #=> 6857
