=begin
If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?


NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
=end
#######################################################################################

def count_letters(*args)
	# allow method to accept a min and max value as argument, a single value, a range, an array, or multiple (>2) values
	if args[0].is_a?(Integer) && args.length <= 2
		values = (args.first..args.last)
	elsif args[0].is_a?(Range) || args[0].is_a?(Array)
		values = args[0]
	end

	values.map{|num| big_int_in_words(num).length} # find length of each num in words
		.inject(:+) # return sum of all lengths
end

# takes an integer < 20_000 and returns a string of the integer written in words (no spaces or hyphens).
def big_int_in_words(num)
	# get values for each decimal place
	thousands, mod = num.divmod(1000)
	hundreds, mod = mod.divmod(100)
	tens, ones = mod.divmod(10)
	# alternatively:
	# ten_thousands, thousands, hundreds, tens, ones = ("%05d" % num).chars.map(&:to_i)
	# thousands += ten_thousands * 10

	words = ""

	# add words for thousands
	words += (small_int_in_words(thousands) + "thousand") if thousands > 0
	# add words for hundreds
	words += (small_int_in_words(hundreds) + "hundred") if hundreds > 0
	# add "and" if necessary: there are hundreds or thousands and there are tens or ones
	words += "and" if words.length > 0 && ones + tens > 0
	# add words for tens if tens is twenty or higher
	words += int_times_ten_in_words(tens) if tens > 1
	# add words for remaining 1..19
	if tens == 1
		words += small_int_in_words(ones + 10)
	else
		words += small_int_in_words(ones)
	end

	words
end

#takes an integer < 20 and returns a string of the integer written in words.
def small_int_in_words(num)
	case num
		when 19 then "nineteen"
		when 18 then "eighteen"
		when 17 then "seventeen"
		when 16 then "sixteen"
		when 15 then "fifteen"
		when 14 then "fourteen"
		when 13 then "thirteen"
		when 12 then "twelve"
		when 11 then "eleven"
		when 10 then "ten"
		when 9 then "nine"
		when 8 then "eight"
		when 7 then "seven"
		when 6 then "six"
		when 5 then "five"
		when 4 then "four"
		when 3 then "three"
		when 2 then "two"
		when 1 then "one"
	else
		""
	end
end

#takes an integer < 10 and returns a string of the integer * 10 written in words.
def int_times_ten_in_words(num)
	case num
		when 9 then "ninety"
		when 8 then "eighty"
		when 7 then "seventy"
		when 6 then "sixty"
		when 5 then "fifty"
		when 4 then "forty"
		when 3 then "thirty"
		when 2 then "twenty"
		when 1 then "ten"
	else
		""
	end
end

# a standalone alternate approach for the specific project euler problem of counting 1..1000
=begin
def euler17_count_letters
	count = 0
	count += "onethousand".length #for 1000
	count += "hundred".length * (999 - 99) # for every time "hundred" is used (every num except 1000 and the first 99)
	count += "and".length * (99 * 9) #for each of the 99 "and"s in each of the 9 hundreds > 100

	# for each of the hundred "nine (etc.) hundred"s and the 9 "nine"s in each of the 10 hundreds
	count += sum_of_lengths(%w(nine eight seven six five four three two one),(100 + (10 * 9)))
	# for each of the hundreds
	count += sum_of_lengths(%w(nineteen eighteen seventeen sixteen fifteen fourteen thirteen twelve eleven ten),10)
  # for each of the 10 "ninety"s (etc.) in each of the 10 hundreds
	count += sum_of_lengths(%w(ninety eighty seventy sixty fifty forty thirty twenty),10 * 10)
end

# helper method method takes array of words and returns total length of all words written `qty` times
def sum_of_lengths(words, qty=1)
	words.inject(0){|memo, word| memo + word.length} * qty
end
=end

#p euler17_count_letters #=> 21124
p count_letters(1..1000) #=> 21124
