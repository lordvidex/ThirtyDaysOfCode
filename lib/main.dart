void printGrain(int squarePos){
  
  /// Accuracy is [Maximal]
  ///by using BigInt in case results are 
  /// processed based on 32 bits int
  ///Possible max value 2^64-1

  //grains on the nth square position is 2^(n-1)
  print('Square $squarePos: ${BigInt.two.pow(squarePos-1)} grains');
  
  //Using Sum of GP a*(r^n-1)/r-1=>r^n-1 where r=2;n=64
  print('Total number of grains: ${BigInt.two.pow(64)-BigInt.one}');
}
void main(){
  var square = 64;
  printGrain(square);
}