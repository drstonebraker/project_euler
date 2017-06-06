=begin
A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
=end
#######################################################################################




##################
# this set of methods was the first solution I wrote.  It is less efficient but possibly more readable
##################
=begin
require 'set'
MAX_VAL = 28123

#returns sum of all positive integers which cannot be written as the sum of two abundant numbers.
def non_abundant_sums
	abundant_sums = sums_of_two_abundants(MAX_VAL)

	(1..MAX_VAL).reject{|num| abundant_sums.include?(num)}
		.inject(:+)
end

# returns set of all sums of two abundants, where abundants are all abundants < max
def sums_of_two_abundants(max)
	sums = Set.new
	find_abundant_numbers(max)
		.repeated_combination(2) # get all combinations of two abundant numbers
		.each{|combo| sums.add?(combo.inject(:+))} # add combo sum to sums if it's not already there
	sums
end

# returns array of positive abundant integers < max
def find_abundant_numbers(max)
	(2...max).select{|num| is_abundant?(num)}
end

# returns boolean, true if num is abundant
def is_abundant?(num)
	find_proper_divisors(num).inject(:+) > num
end

#returns array of proper divisors of num
def find_proper_divisors(num)
	sqrt = Math.sqrt(num)
	#selecting divisors among 1..sqrt returns smallest of every pair of factors which produce num
	(1..sqrt).select{|n| num % n == 0}
		.flat_map do |prop_divisor| # get the other factor of every pair
			# other than sqrt (since we already have it) and num itself (not proper)
			if [1,sqrt].include?(prop_divisor)
				prop_divisor
			else
				[prop_divisor, num / prop_divisor]
			end
		end
end
=end

require 'set'
MAX_VAL = 28123

#returns sum of all positive integers which cannot be written as the sum of two abundant numbers.
def non_abundant_sums
	# get set of all sums of two abundant numbers
	abundant_sums = sums_of_two_abundants(MAX_VAL)

	# get sum of all numbers less than 28123 which are not a part of the abundant_sums set
	sum = 0
	(1..MAX_VAL).each{|num| sum += num unless abundant_sums.include?(num)}

	sum
end

# returns set of all sums of two abundants, where abundants are all abundants < max
def sums_of_two_abundants(max)
	# get array of all abundant numbers less than max
	abundant_nums = find_abundant_numbers(max).to_a

	# will store every sum of two abundant numbers
	sums_of_abundants = Set.new

	# find every (inclusive) combination of two abundant numbers and store their sum in sums
	abundant_nums.each_with_index do |abundant_first, i|
		abundant_nums[i..-1].each do |abundant_last|
			sums_of_abundants.add(abundant_first + abundant_last)
		end
	end

	sums_of_abundants
end

# returns set of positive abundant integers < max
def find_abundant_numbers(max)
	abundant_nums = Set.new

	# all numbers to check if they are abundant
	range_arr = (2...max).to_a

	until range_arr.empty?
		num = range_arr.shift

		if is_abundant?(num)
			# store num in set of abundant nums
			abundant_nums.add?(num)

			# all multiples of abundant nums will be also be abundant, so store those too
			# this enhances efficiency by avoiding having to build a list of proper divisors for those numbers
			multiple = num
			while multiple < range_arr.length
				abundant_nums.add?(range_arr[multiple - 1]) if range_arr[multiple - 1]
				# mark as already stored
				range_arr[multiple - 1] = false
				# get index+1 of next multiple
				multiple += num
			end
		end

		# find next number that hasn't already been added to abundant_nums
		range_arr.shift while range_arr[0] == false
	end

	# return set of abundant nums
	abundant_nums
end

# returns boolean, true if num is abundant
def is_abundant?(num)
	find_proper_divisors_sum(num) > num
end

# returns sum of proper divisors of num
def find_proper_divisors_sum(num)
	sum = 0
	sqrt = Math.sqrt(num)

	# add all divisors into sum
	(1..sqrt).each do |n|
		# if num is a proper divisor
		if num % n == 0
			# add it--and its pair (other than 1 and sqrt)--into sum
			if [1,sqrt].include?(n)
				sum += n
			else
				sum += (n + (num / n))
			end
		end
	end

	sum
end

p non_abundant_sums #=> 4179871
