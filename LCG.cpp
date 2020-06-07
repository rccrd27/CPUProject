#include <iostream>


using namespace std;

int lcong(const unsigned int a, const unsigned int b, const int n, const unsigned int s){
    unsigned int y = s;
    unsigned int sum = 0;

    for (int i = n ; i > 0; i--){
        y = y*a + b; // calculate the new pseudo-random number
        sum = sum + y; // add it to the total 
    }
    return sum; 
}

int main()
{
int a, b, n, s;
cerr << "input a, b, n, s"<< endl;

cin >> a >> b >> n >> s;

    cout << "sum = " << lcong(a, b, n, s) << endl;
}