=begin
A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

=end
#######################################################################################


############
# naive approach: O(n!) (yikes!)
############
=begin
def nth_permutation(elements, target=nil)
	# get sorted list of permutations
	perms = elements.permutation(elements.length)
		.sort

	# return targeted permutation, or sorted list if no target (to test against example test case)
	target ? perms[target - 1].join : perms
end
=end

# efficient approach: O(n) (not counting the sort) / or [I think] O(n log n) with the sort
def nth_permutation(elements_input, target_input)
	# sort elements just to make method work for unsorted lists
	elements = elements_input.map(&:to_s).sort
	# using target = 0 would give us first permutation, therefore target = (1_000_000 - 1) will give us millionth permutation
	target = target_input - 1
	# will accumulate each consecutive element as it is calculated
	result = ""

	# stores number of remaining permutable elements for each possible next element
	num_of_elements_remaining = elements.length
	# stores number of possible further permutations for each possible next element
	num_of_perms_remaining = factorial(num_of_elements_remaining)

	# target is too high; not enough permutations exist
	return nil if target_input > num_of_perms_remaining

	until elements.empty?
		# find x where x is how any permutations exist with the same next element
		# equivalent to factorial(num_of_elements_remaining - 1)
		num_of_perms_remaining /= num_of_elements_remaining
		num_of_elements_remaining -= 1
		# each consecutive possible next element accounts for an additional `num_of_perms_remaining` possible permutations.
		# therefore, if the target is less than num_of_perms_remaining, we the next element we need is the first
		# available ordered element.  if target is between num_of_perms_remaining and (num_of_perms_remaining * 2), then we
		# need the second available ordered element, etc.
		# the remainder is the number of possible permutations remaining between `result + elements.join` and the target permutation,
		# so we make that remainder the new target
		next_element, target = target.divmod(num_of_perms_remaining)

		# add appropriate element to result and remove from available elements
		result += elements.delete_at(next_element)
	end

	result
end

def factorial(n)
	(2..n).inject(:*) || 1
end

p nth_permutation((0..9).to_a, 1_000_000) #=> "2783915460"
