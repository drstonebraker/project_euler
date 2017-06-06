=begin
The following iterative sequence is defined for the set of positive integers:

n → n/2 (n is even)
n → 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:

13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.
=end
#######################################################################################

#finds the integer between min and max that produces the longest collatz sequence
def longest_collatz_sequence(max, min=1)
	# stores n for longest chain
	longest_n = 0
	# stores length of longest chain
	longest_chain = 0
	# caches lengths
	collatz_lengths = {}

	# check each value between min and max
	(min..max).each do |n|
		# counts length of chain
		count = 1

		#copy n, to preserve value of n for storing when longest chain is found
		i = n

		# until collatz sequence has terminated
		until i <= 1
			# if collatz length has already been found for current i
			if collatz_lengths[i]
				# for remainder of sequence, use the length that was already found
				count += collatz_lengths[i]
				break
			else
				# store next number in sequence
				i = i.even? ? i / 2 : 3 * i + 1
				#increment chain length count
				count +=1
			end
		end

		# cache sequence length for current n
		collatz_lengths[n] = count

		# if current n created longest chain, store values
		if count > longest_chain
			longest_chain = count
			longest_n = n
		end

	end
	longest_n
end

p longest_collatz_sequence(1_000_000 - 1) #=> 837799
