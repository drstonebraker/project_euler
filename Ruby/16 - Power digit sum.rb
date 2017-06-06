=begin
2**15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 2**1000?
=end
#######################################################################################

def sum_power_digits(base, exponent)
	(base ** exponent) # get power
		.to_s.chars.map(&:to_i) # get array of digits
		.inject(0,:+) # sum array of digits
end

p sum_power_digits(2, 1000) #=> 1366
