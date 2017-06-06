=begin
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

a**2 + b**2 = c**2
For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
=end
#######################################################################################

# returns a * b * c where a < b < c and a**2 + b**2 = c**2 and a + b + c = 1000
def special_pythagorean_triplet
	# build list of squares
	squares = (1...1000).map{|num| num ** 2}

	# check each possible `a**2` value
	squares.each_with_index do |a2, a_idx|
		# check each possible `b**2` value for every `a**2`
		squares[(a_idx + 1)..-1].each_with_index do |b2, b_idx|
			# find `c**2` if it exists
			c = Math.sqrt(a2 + b2).round

			# if c was valid and a + b + c == 1000, return product
			if (c < 1000) && ((c ** 2) == a2 + b2) && ((a = Math.sqrt(a2)) + (b = Math.sqrt(b2)) + c) == 1000
				return (a * b * c).to_i
			end
		end
	end
end

p special_pythagorean_triplet #=> 31875000
