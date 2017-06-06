=begin
A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

1/2	= 	0.5
1/3	= 	0.(3)
1/4	= 	0.25
1/5	= 	0.2
1/6	= 	0.1(6)
1/7	= 	0.(142857)
1/8	= 	0.125
1/9	= 	0.(1)
1/10	= 	0.1
Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.
=end
#######################################################################################

def most_repeating_digits(max)
	longest_rec_length = 0 #stores length of longest recurring digits found so far
	best_denom = 0 #stores denom that has longest length of recurring digits so far

	#test every possible value for denom
	max.downto(2) do |denom|
		# max repeating length should be denom - 1*, so if denom <= longest_rec_length, we won't find anything longer
		break if longest_rec_length >= denom

		# get the decimal part of the number
		decimals = build_repeating_decimals(denom)

		# get rid of all but the repeating subsets
		repeats = decimals.scan(/((\d+)\2)/).flatten[1].to_s

		# find length of longest repeating subset for current denom
		current_longest_rec_length = get_longest_rec_length(repeats)

		# if this is the longest found so far, store values.
		if current_longest_rec_length > longest_rec_length
			longest_rec_length = current_longest_rec_length
			best_denom = denom
		end

	end
	best_denom
end


# method takes string of repeating digits to find the length of the subset that is the true repeating subset
def get_longest_rec_length(digits)
	loop do
		# look for repeating sequence of digits
		subset = digits.scan(/((\d+)\2)/).flatten[1]
		# break if none found.  digits is the true recurring sequence
		break if subset.nil?

		splits = digits.split(subset)
		# splits will be empty iff digits is a superset of an even number of the recurring sequence
		unless splits.empty?
			# iff digits is a superset of an odd-numbered quantity the recurring sequence,
			# then the non-empty string in `splits` (`splits.last`) is the recurring sequence.
			# if digits is a superset of `splits.last`, return its length
			super_size = digits.length / splits.last.length
			return splits.last.length if (splits.last * super_size == digits)
			# digits is not a superset of subset
			# (subset is some smaller repeating pattern within digits, like "0" in "001")
			# digits is the true recurring sequence
			break
		end

		# digits is a superset of subset, and subset is a superset if recurring pattern. repeat loop with subset
		digits = subset
	end
	digits.length
end

# method returns string of decimal digits for (1 / denom) if it is non-terminating, or an empty string if it is terminating
def build_repeating_decimals(denom)
	decimals = ""
	i = 0
	n = 10

	# max repeating length should be denom - 1*, so retrieving denom * 2 digits (plus a buffer of 5 for any leading nonrecurring digits)
	# should give us enough to check for repeating patterns
	max_length = (denom * 2) + 5

	# do long division (using floats doesn't provide enough decimal places) until termination or until we have enough digits
	until (div_mod = n.divmod(denom)).last.zero? || i > max_length
		decimals += div_mod.first.to_s
		n = div_mod.last * 10
		i +=1
	end

	# if i isn't greater than max_length, then we know there are no repeating digits, so return only an empty string
	i > max_length ? decimals += div_mod.first.to_s : ""
end
# *according to https://en.wikipedia.org/wiki/Repeating_decimal#Other_properties_of_repetend_lengths

p most_repeating_digits(1000) #=> 983
