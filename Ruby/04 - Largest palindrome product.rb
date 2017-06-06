=begin
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

Find the largest palindrome made from the product of two 3-digit numbers.
=end
#######################################################################################

# method returns largest palindrome that is the product of 2 `digit_length`-digit numbers
def largest_palindrome_product(digit_length)
	# smallest value with length equal to `digit_length`
	min_val = 10 ** (digit_length - 1)
	# largest value with length equal to `digit_length`
	max_val = (10 ** digit_length) - 1
	# stores largest palindrome yet found
	max_palindrome = 0
	# get all numbers of digit_length length in descending order
	n_digit_numbers = max_val.downto(min_val).to_a

	# check each inclusive combination of 2 numbers
	n_digit_numbers.each_with_index do |first_num, idx|
		# since iterator is going in descending order, first_num ** 2 is the highest of any products
		# remaining to be found in the iteration.  If it is <= the value of a palindrome we've already found,
		# no need to keep looking.
		break if (first_num ** 2) <= max_palindrome

		n_digit_numbers[idx..-1].each do |second_num|
			product = first_num * second_num
			# if product is a palindrome and larger than any previously found, store value
			if product > max_palindrome && is_palindrome?(product)
				max_palindrome = product
			end
		end
	end

	max_palindrome
end

# single-line/chained version of above method
=begin
def largest_palindrome_product(digit_length)
	((10 ** (digit_length - 1))...(10 ** digit_length)).to_a # get all numbers of digit_length length
		.repeated_combination(2) # get all combinations of two of these numbers
		.map{|combo| combo.inject(:*)} # find product of each combination
		.select{|product| is_palindrome?(product)} # find all palindrome products
		.max # find largest palindrome product
end
=end

# method takes string or numeric and returns boolean: true if input is a palindrome
def is_palindrome?(value)
	value.to_s == value.to_s.reverse
end

p largest_palindrome_product(3) #=> 906609
