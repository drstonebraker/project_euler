=begin
Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
=end
#######################################################################################

def sum_of_even_fibonaccis(max)
	# stores last two fib numbers, starting with beginning sequence
	last_fibs = [1,2]
	# stores sum of even fibonaccis
	sum_of_evens = 0
	# stores last fib found
	fib = 2

	until fib > max
		# add last fib to sum if it's even
		sum_of_evens += fib if fib.even?
		# get next fib
		fib = last_fibs.inject(:+)
		# update last_fibs
		last_fibs = [last_fibs[1]] << fib
	end

	sum_of_evens
end

p sum_of_even_fibonaccis(4_000_000) #=> 4613732