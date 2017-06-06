=begin
Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.
=end
#######################################################################################

# returns sum of all positive amicable numbers < max
def sum_amicable_numbers(max)
	amicables = (2...max).select{|num| is_amicable?(num)}
	amicables.inject(:+) # sum them
end

#returns boolean, true if num is amicable
def is_amicable?(num_a)
	num_b = find_proper_divisors(num_a).inject(:+)
	find_proper_divisors(num_b).inject(:+) == num_a && num_a != num_b
end

#returns array of proper divisors of num
def find_proper_divisors(num)
	sqrt = Math.sqrt(num)
	#selecting divisors among 1..sqrt returns smallest of every pair of factors which produce num
	small_divisors = (1..sqrt).select{|n| num % n == 0}
	proper_divisors = small_divisors.flat_map do |prop_divisor| # get the other factor of every pair
			# other than sqrt (since we already have it) and num itself (not proper)
			if [1,sqrt].include?(prop_divisor)
				prop_divisor
			else
				[prop_divisor, num / prop_divisor]
			end
		end

	proper_divisors
end

p sum_amicable_numbers(10_000) #=> 31626
