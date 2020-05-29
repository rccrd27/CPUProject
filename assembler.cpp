#include <iostream>
#include <vector>
#include <cassert>
using namespace std;

string dec_to_hex(int dec_num);
string addbit(char a);
string hex_the_reg(char rd, char rs);

string code(string x, string fi, int cycle) // x=opcode, fi=full input
{
    // MU0 instructions //
  if(x == "STA")
  {
    string c = "0";
    string operand;
    operand = fi.substr(6, (fi.length() - 1));
    return c + operand;

  }
  else if(x == "JMP")
  {
    string c = "1";
    string operand;
    operand = fi.substr(6, (fi.length() - 1));
    return c + operand;
}
  else if(x == "JEQ")
  {
    string operand1 = fi.substr(10, (fi.length() - 1));
    string operand2 = fi.substr(11, (fi.length() - 1));
    string bit3 = addbit(fi[10]);
    if(fi[5] == '0')
    {
      return "2" + operand1;
    }
    else if(fi[5] == '1')
    {
      return "2" + bit3 + operand2;
    }
    else if(fi[5] == '2')
    {
      return "3" + operand1;
    }
    else if(fi[5] == '3')
    {
      return "3" + bit3 + operand2;
    }
    else{return "not valid input";}
  }
  else if(x == "STP")
  {
    string a = dec_to_hex(cycle);
    int size = a.size();
    if(size == 1) {return "400" + a;}
    else if(size == 2) {return "40" + a;}
    else if(size == 3) {return "4" + a;}
    else{return "4000";}
  }
  else if(x == "LDA")
  {
    string c = "5";
    string operand;
    operand = fi.substr(6, (fi.length() - 1));
    return c + operand;
  }
  else if(x == "ADD" && fi[5] == 'x')
  {
    string c = "5";
    string operand;
    operand = fi.substr(7, (fi.length() - 1));
    string bit3 = addbit(fi[6]);
    return c + bit3 + operand;
}
  else if(x == "JMS")
  {
    string c = "6";
    string operand;
    operand = fi.substr(6, (fi.length() - 1));
    return c + operand;
  }
  else if(x == "BBL") {return "7000";}

      // ARMish instructions //

  else if(x == "ADD" && fi[5] != 'x')
  {
    string reg = hex_the_reg(fi[5], fi[9]);
    return "800" + reg;
  }
  else if(x == "SUB")
  {
    string reg = hex_the_reg(fi[5], fi[9]);
    return "900" + reg;
  }
  else if(x == "MOV")     // Need to check !!!!
  {
    string reg = hex_the_reg(fi[5], fi[9]);
    return "A00" + reg;
  }
  else if(x == "INC")
  {
    string reg = hex_the_reg(fi[5], fi[9]);
    return "A80" + reg;
  }
  else if(x == "LSR")
  {
    string reg = hex_the_reg(fi[5], fi[9]);
    return "B00" + reg;
  }
  else if(x == "DEC")
  {
    string reg = hex_the_reg(fi[5], fi[9]);
    return "C00" + reg;
  }
  else if(x == "MUL")
  {
    string reg = hex_the_reg(fi[5], fi[9]);
    return "D00" + reg;
  }
  else if(x == "LDR")         //Need to check !!!!
  {
    if(fi[5] == '0') {return "E000";}
    else if(fi[5] == '1') {return "E004";}
    else if(fi[5] == '2') {return "E008";}
    else if(fi[5] == '3') {return "E00C";}
    else{return "not valid input";}
  }
  else  {return "not valid input";}
}
string convert_line(string x, int cycle)
{
  string name;
  string outp;
  name = x.substr(0, 3);
  outp = code(name, x, cycle);
  return outp;


}


int main()
{
  int cycle = 0;
  string x;
  vector<string> y;

while(getline(cin, x))
{
  x = convert_line(x, cycle);
  y.push_back(x);
  cycle = cycle + 1;
}


for(int i=0; i<y.size(); i++)
{
  cout << dec_to_hex(i) << ": " << y[i] << endl;
}
}






string addbit(char a)
{
  if(a == '0') {return "8";}
  else if(a == '1') {return "9";}
  else if(a == '2') {return "A";}
  else if(a == '3') {return "B";}
  else if(a == '4') {return "C";}
  else if(a == '5') {return "D";}
  else if(a == '6') {return "E";}
  else if(a == '7') {return "F";}
  else{return "not valid input";}
}

string dec_to_hex(int dec_num)
{
 int r;
string hexdec_num="";
char hex[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};


if(dec_num == 0){
  return hexdec_num = hex[0];
}

else while(dec_num>0)
{
  r = dec_num % 16;
  hexdec_num = hex[r] + hexdec_num;
  dec_num = dec_num/16;
}

  return hexdec_num;
}

string hex_the_reg(char rd, char rs)
{
  if(rd=='0'){return string(1, rs);}
  else if(rd=='1' && rs=='0'){return "4";}
  else if(rd=='1' && rs=='1'){return "5";}
  else if(rd=='1' && rs=='2'){return "6";}
  else if(rd=='1' && rs=='3'){return "7";}
  else if(rd=='2' && rs=='0'){return "8";}
  else if(rd=='2' && rs=='1'){return "9";}
  else if(rd=='2' && rs=='2'){return "A";}
  else if(rd=='2' && rs=='3'){return "B";}
  else if(rd=='3' && rs=='0'){return "C";}
  else if(rd=='3' && rs=='1'){return "D";}
  else if(rd=='3' && rs=='2'){return "E";}
  else if(rd=='3' && rs=='3'){return "F";}
  else{return "not valid input";}
}
