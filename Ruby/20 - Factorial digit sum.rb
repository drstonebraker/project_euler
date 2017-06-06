=begin
n! means n × (n − 1) × ... × 3 × 2 × 1

For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!
=end
#######################################################################################

#returns sum of digits of num factorial
def factorial_digit_sum(num)
	(1..num).inject(:*) #find num!
		.to_s.chars.map(&:to_i) #get array of digits
		.inject(0,:+) #find sum of digits
end

p factorial_digit_sum(100) #=> 648
