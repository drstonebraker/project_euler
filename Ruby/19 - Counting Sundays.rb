=begin
You are given the following information, but you may prefer to do some research for yourself.

1 Jan 1900 was a Monday.
Thirty days has September,
April, June and November.
All the rest have thirty-one,
Saving February alone,
Which has twenty-eight, rain or shine.
And on leap years, twenty-nine.
A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
=end
#######################################################################################


# using Date class
=begin
def count_sunday_months(begin_date_input, end_date_input)
	# create Date objects from arguments
	require "date"
	begin_date = Date.new(*begin_date_input)
	end_date = Date.new(*end_date_input)
	count = 0
	until begin_date > end_date
		count += 1 if begin_date.sunday?
		begin_date = begin_date >> 1 # add one month to begin_date
	end
	count
end
=end

# not using Date class.  Method takes two dates in the form of [year, month, day], and
# finds the number of Sundays between the two dates which fall on the first of a month
def count_sunday_months(begin_date_full, end_date_full)
	# handle inputs in any order
	begin_date_full, end_date_full = [begin_date_full, end_date_full].sort

	year, month, begin_day = begin_date_full
	end_year, end_month, end_day = end_date_full

	# find next first of month if the begin_date isn't the first of the month
	if begin_day != 1
		year += 1 if (month == 12)
		month = (month % 12) + 1
	end

	month_days = {
		1 => 31,
		2 => 28,
		3 => 31,
		4 => 30,
		5 => 31,
		6 => 30,
		7 => 31,
		8 => 31,
		9 => 30,
		10 => 31,
		11 => 30,
		12 => 31
		}

	# since Jan 1 1900 was a monday and 1900 is not a leap year,
	# Jan 1 1901 should be 366 days from Sun, Dec 31 1899.
	# But I am using a helper method to allow this method to work for any input dates
	days_from_sunday = find_days_from_sunday(year, month, 1)
	sunday_count = 0

	until (year == end_year && month > end_month) || (year > end_year)
		# increment count if the number of days from Sun, 12/31/1899 is divisible by 7
		sunday_count += 1 if (days_from_sunday % 7 == 0)

		# go to first day of next month
		days_from_sunday += month_days[month]
		# add 1 for leap days
		days_from_sunday += 1 if (month == 2) && (year % 4 == 0) && (year % 100 != 0)

		# increment date
		year += 1 if month == 12
		month = (month % 12) + 1
	end

	sunday_count
end

# helper method takes a gregorian year, month, and date (day) and returns number of days since Sunday, Dec 31 1899
def find_days_from_sunday(year, month, date)
	result = 0
	full_years = year - 1900
	# add 365 for each full year
	result += full_years * 365
	# add 1 for each full leap year
	result += (full_years - 1) / 4

	month_days = [31,28,31,30,31,30,31,31,30,31,30,31]
	# add days for full months in final calendar year
	result += month_days[0...(month - 1)].inject(0,:+)
	# add 1 for leap day in final calendar year
	result += 1 if (month > 2) && (year % 4 == 0) && (year % 100 != 0)

	# add for number of days into final month
	result += date

	# add one for dates Dec 31 1899 or earlier
	result += 1 if year <= 1899

	result
end

p count_sunday_months([1901,1,1], [2000,12,31]) #=> 171
