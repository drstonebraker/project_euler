=begin
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
=end
#######################################################################################

# prime factorization approach:
=begin
# method returns smallest multiple of all integers 1 to max
def smallest_multiple(max)
	require "prime"
	(1..max).map{|num| Hash[num.prime_division]} # get prime factors of each num
		.inject do |memo, factors|
			# create hash of every prime factor used, with the greatest exponent used for that factor
			memo.merge(factors) {|prime, oldval, newval| [oldval, newval].max}
		end
		.map{|prime, exponent| prime ** exponent} # get prime powers
		.inject(:*) # get product of prime powers
end
=end

# built-in approach:
=begin
def smallest_multiple(max)
	(1..max).inject(:lcm)
end
=end

# euclideon approach:
def smallest_multiple(max)
	my_lcm(*(1..max))
end

# helper method returns the least common multiple of all Integer arguments
def my_lcm(*args)
	args.inject do |memo, num|
		product = memo * num
		product / my_gcd(memo, num)
	end
end

# helper method returns the greatest common denominator of all Integer arguments, using euclideon algorithm
def my_gcd(*args)
	args.inject do |memo, num|
		until [memo, num].include?(0)
			mod = memo % num
			memo, num = num, mod
		end
		[memo, num].max
	end
end

p smallest_multiple(20) #=> 232792560
