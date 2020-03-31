import 'dart:math';

int combination(int n, int r) {
  if (n == 0 || r == 0) {
    return 1;
  }
  int x = 1; //numerator 
  int d = 1; //denominator
  for (int i = max(r, n - r) + 1, j = 1; i <= n; i++, j++) {
    x *= i;
    d *= j;
  }
  x ~/= d;
  return x;
}

void pascalTriangle(int numberOfRows) {
  //Instead of looping and recreating arrays.. we can simply use Combinations to
  //generate the fields in each row
  for (int i = 0; i < numberOfRows; i++) {
    List<int> arr = [];
    int count = i;
    while (count >= 0) {
      arr.add(combination(i, count));
      count--;
    }
    print(arr.join(' '));
  }
}

void main() {
  int numberOfRows = 10;
  pascalTriangle(numberOfRows);
}
