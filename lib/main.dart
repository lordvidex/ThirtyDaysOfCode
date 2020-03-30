import 'dart:math';
String differenceOfSquares(int n){
  //absolute difference of squares of sum  &&&   sum of squares
  return (pow((n*(n+1))/2,2)-((n*(n+1)*(2*n+1))/6)).abs().toStringAsFixed(0);
}
void main() {
  int n = 10;
  print(differenceOfSquares(n));  
}