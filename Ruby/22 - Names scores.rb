=begin
Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.

For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.

What is the total of all the name scores in the file?
=end
#######################################################################################


def names_scores_sum(filename)
	File.read(filename) #get string from file
		.split(/\"?,?\"/) #create array of names
		.sort
		.map.with_index { |name, i| # map each name to its score
			name.chars #split name into characters
				.map{|char| char.ord - 64 } # map each char to its alphabetical value
				.inject(0,:+) # sum alphabetical value in name
				.*(i) # multiply by order in list
		}
		.inject(:+) #sum all name scores
end

# again, I've seen mixed advice on whether chaining is good or bad practice.  Here is an unchained version.
=begin
def names_scores_sum(filename)
	names_s = File.read(filename) #get string from file
	names_arr =	names_s.split(/\"?,?\"/) #create array of names
	names_arr = names_arr.sort
	name_scores_arr = names_arr.map.with_index do |name, i| # map each name to its score
			chars_arr = name.chars #split name into characters
			char_values_arr = chars_arr.map{|char| char.ord - 64 } # map each char to its alphabetical value
			char_values_sum = char_values_arr.inject(0,:+) # sum alphabetical value in name
			char_values_sum * i # multiply by order in list (first element of list is an empty string)
		end
	name_scores_arr.inject(:+) #sum all name scores
end
=end

p names_scores_sum('.\files\p022_names.txt') #=> 871198282
