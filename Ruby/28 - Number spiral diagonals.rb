=begin
Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?
=end
#######################################################################################

def spiral_diagonals_sum(size)
	# find highest number
	num = size ** 2
	# begin sum
	corners_sum = num
	# distance to next corner
	distance_to_next_corner = size - 1

	until distance_to_next_corner < 1
		# find next four diagonal numbers (descending) and add them to sum
		4.times {corners_sum += (num -= distance_to_next_corner)}
		# reduce distance to next diagonal for next go around
		distance_to_next_corner -= 2
	end

	corners_sum
end

p spiral_diagonals_sum(1001) #=> 669171001
