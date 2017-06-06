=begin
Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

How many such routes are there through a 20×20 grid?
=end
#######################################################################################



=begin
Author NOTE:
This function calculates an answer by building a matrix of the number of paths that can be taken from each node. 1 path follows the lattice all the way to the right and all the way down; this is not included in the matrix, but is added at the end. If a path were to go right all the way until the second to last path down, it encounters one possible path for each opportunity to turn right again.  This is the first row of the matrix. The third to last path down is the second row of the matrix, and each opportunity to turn right again offers the number of paths equal to the sum of the remaining (at this height and below) paths in the next vertical path to the right (which is represented by the previous row in the matrix). Checking the number of paths available to each node on each vertical path, summing them, and then adding the one for the path that goes all the way to the right and all the way down, then summing all these values, provides the answer.

If you were to draw out the lattice and write on each node/intersection (not counting top and right side of lattice) how many paths are available from that node going right, it would look like this method's matrix if the matrix were rotated 90 deg to the right.
=end

# takes 1 argument for square size, 2 arguments for rectangular size lattice.  can calculate for sizes up to a little over 600x600 in less than one minute.
def count_routes(x, y=x)
	#create matrix. fill with ones to start
	matrix = Array.new(y){Array.new(x){1}} #all the values except the first row will be (potentially) modified with #map.

	(1..(y - 1)).each do |i| #start with second row
		matrix[i].map!.with_index do |node, j|
			# add all new paths available (at current height and below) in next vertical path to right, which is represented in matrix as the row above.
			matrix[i-1][j..-1].inject(:+)
		end
	end

	# add one for the path that goes all the way right before going down
	matrix.flatten.inject(:+) + 1
end

p count_routes(20) #=> 137846528820
