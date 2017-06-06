=begin
By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.

3
7 4
2 4 6
8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom of the triangle below:

75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67, is the same challenge with a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)
=end
#######################################################################################

def find_best_route_sum(triangle_input)
	# copy input since triangle will be modified
	triangle = triangle_input.dup.map(&:dup)
	#begin with second to last row
	i = triangle.length - 2
	while i >= 0
		triangle[i].map!.with_index do |num, j|
			#map each num to the sum of it and the greater of the next two possible nums (either down left or down right)
			[triangle[i+1][j], triangle[i+1][j+1]].max.to_i + num.to_i
		end
		i -= 1 #go to next row up
	end
	#top num on the triangle should now be the sum of the largest route
	triangle.first.first
end

triangle = [
%W(75),
%W(95 64),
%W(17 47 82),
%W(18 35 87 10),
%W(20 04 82 47 65),
%W(19 01 23 75 03 34),
%W(88 02 77 73 07 63 67),
%W(99 65 04 28 06 16 70 92),
%W(41 41 26 56 83 40 80 70 33),
%W(41 48 72 33 47 32 37 16 94 29),
%W(53 71 44 65 25 43 91 52 97 51 14),
%W(70 11 33 28 77 73 17 78 39 68 17 57),
%W(91 71 52 38 17 14 91 43 58 50 27 29 48),
%W(63 66 04 68 89 53 67 30 73 16 69 87 40 31),
%W(04 62 98 27 23 09 70 98 73 93 38 53 60 04 23)
]

p find_best_route_sum(triangle) #=> 1074
