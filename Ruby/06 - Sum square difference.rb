=begin
The sum of the squares of the first ten natural numbers is,

1**2 + 2**2 + ... + 10**2 = 385
The square of the sum of the first ten natural numbers is,

(1 + 2 + ... + 10)**2 = 55**2 = 3025
Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.

Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
=end
#######################################################################################

# method returns difference between square of sum and sum of squares for all integers 1 to max
def sum_square_difference(max)
	(square_of_sum(max) - sum_of_squares(max)).abs
end

# method sums the squares of all integers 1 to max
def sum_of_squares(max)
	squares = (1..max).map{|n| n ** 2}
	squares.inject(:+) # sum the squares
end

# method squares the sum of all integers 1 to max
def square_of_sum(max)
	sum = (1..max).inject(:+)
	sum ** 2
end

p sum_square_difference(100) #=> 25164150
