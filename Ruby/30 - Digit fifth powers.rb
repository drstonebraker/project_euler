=begin
Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

1634 = 1**4 + 6**4 + 3**4 + 4**4
8208 = 8**4 + 2**4 + 0**4 + 8**4
9474 = 9**4 + 4**4 + 7**4 + 4**4
As 1 = 1**4 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
=end
#######################################################################################

# method returns the sum of all the numbers that can be written as the sum of the nth powers of their digits, where n is a positive integer
def digit_nth_powers(n)
	# collect all integers which are the sum of the digits to the nth power
	nth_power_sums = (10..find_max_nth_power(n)).select do |prospect|
		prospect == prospect.to_s.chars.map{|digit| digit.to_i ** n}.inject(:+)
	end

	# return sum of these numbers
	nth_power_sums.inject(:+)
end

# takes an integer n and returns a number above which there are no numbers that are equal to the sum of each of their digits taken to the nth power.
def find_max_nth_power(n)
	num_of_digits = 2

	(num_of_digits += 1) until (num_of_digits * 9 ** n) < (("9" * num_of_digits).to_i + 1)

	("9" * (num_of_digits)).to_i
end

# NOTE: I also wrote a javascript solution to this problem, but wanted to try it in ruby when I later decided to focus on ruby.
p digit_nth_powers(5) #=> 443839
