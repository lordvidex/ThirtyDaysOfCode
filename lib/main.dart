import 'dart:math';
String findPrimeFactors(int n) {
  assert(!n.isNegative && n.isFinite); //just some extra input validations
  List<num> ans = [];
  while (n % 2 == 0) {
    n ~/= 2;
    ans.add(2);
  }
  for (var x = 3; x <= sqrt(n); x += 2)
    while (n % x == 0) {
      n ~/= x;
      ans.add(x);
    }
  if (n > 2) ans.add(n);
  return ans.join(', ');
}

void main() {
  int n = 10000;
  print(findPrimeFactors(n));
}
