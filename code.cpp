#include <bits/stdc++.h>
using namespace std;

int sumOfDoubleEvenPlace(int number);
int getDigit(int number);

int main(void)
{
    int test1 = 89744563;
    int test2 = 98756421;
    int result1 = 0;
    int result2 = 0;

    result1 = sumOfDoubleEvenPlace(test1);
    cout << "Expected Value: 23  Value: " << result1 << endl;

    result2 = sumOfDoubleEvenPlace(test2);  
    cout << "Expected Value: 21  Value: " << result2 << endl;
	
}
/*
* Function returns the sum of the even placed
* digits(after being doubled) starting from the left. 
* Note that the algorithm starts counting from 1 not 0. Therefore,
* given the number 1234, 4 is the first digit from the left.
* So the even placed digits are 3 and 1 and the odd place digits are
* 4 and 2 from the left.
*/
int sumOfDoubleEvenPlace(int number) {
    int sum = 0;
    int digit;
    
    //Remove first odd digit
    number = number / 10;
    
    while (number > 0) {
        //Grab even placed digit
        digit = (number % 10);
        //Double the digit and pass it to getDigit,
        //Add result to sum
        sum += getDigit(digit*2);
        //Remove current even digit and the next odd digit.
        number = number/100;
    }
    return sum;
}

/* getDigit returns the sum of the digits in
 * a 1 or 2 digit number.
 * if number is < 10,
 * then we return the number.
 * else we return the sum of the digits in the 2 digit
 * number.
 * For example:
 * 1 would return 1
 * 11 would return 2
 * 18 would return 9   
 */
int getDigit(int number) {
    int sum = 0;
    if (number < 10) {
        sum = number;
    } else {
        sum = number%10 + number/10;
    }
    return sum;
}
