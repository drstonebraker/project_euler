=begin
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
=end
#######################################################################################

# I've seen mixed advice on whether it is good or bad practice to chain methods like this,
# so I'm going to write it both ways.
=begin
def mult_three_five_sums(n)
  (3...n).select{|e| e % 3 == 0 or e % 5 == 0}.inject(:+)
end
=end

def mult_three_five_sums(n)
  sum = 0
  (3...n).each do |e|
    sum += e if (e % 3 == 0 || e % 5 == 0)
  end
  sum
end

p mult_three_five_sums(1000) #=> 233168
