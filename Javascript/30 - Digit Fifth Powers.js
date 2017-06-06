/*
Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

1634 = 14 + 64 + 34 + 44
8208 = 84 + 24 + 04 + 84
9474 = 94 + 44 + 74 + 44
As 1 = 14 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
*/

function digitFifthPowers() {
	////////////////////
	//find a max value
	////////////////////
	var numDigits = 2;

	//calculates the smallest number with numDigits number of digits
	var minSum = function(numDigits) {
		return Math.pow(10, numDigits - 1);
	}

	//calculates the largest value that can be achieved by summing the fifth powers of numDigits number of digits.
	var maxSum = function(numDigits) {
		return Math.pow(9,5) * numDigits;
	}

	while (maxSum(numDigits) > minSum(numDigits)) {
		numDigits++;
	}

	//numDigits is 7, meaning there will be no sums higher than 999,999 (we'll stop at Math.pow(10, numDigits - 1)

	////////////////////
	//find valid fifth power sums
	////////////////////
	var fifthPowerSums = [];

	var sum;

	//brute force check every number 10 until our maximum
	for (var n=10; n < Math.pow(10, numDigits - 1); n++) {
		num = ("" + n).split(""); //split into digits
		sum = 0;
		for (var j=0; j<num.length; j++) { //sum fifth power of all digits
			sum += Math.pow(+num[j], 5);
		}
		if (sum === n) { //if n is a valid sum
			fifthPowerSums.push(sum); //push to list of valid sums
		}
	}

	//return sum of valid fifth power sums
	return fifthPowerSums.reduce(function(acc, fifthPowerSum){
		return fifthPowerSum + acc;
	});

}

//NOTE: This was the first problem I attempted, but I later also wrote a ruby solution to this problem after I decided to focus on ruby.
console.log(digitFifthPowers()); // 443839
