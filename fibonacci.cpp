#include <iostream>

using namespace std;

int fib(const int n){
    int y;
    if (n <= 1){
        return y = 1;
    }else{
        y = fib(n-1);
        y = y + fib(n-2);
    return y;
    }
}

int main()
{
    cerr << "input n for fib(n)" << endl;
    int n;
    cin >> n;

    cout << "fib(" << n << ") = " << fib(n) << endl;

}