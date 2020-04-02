//Decided to go OOP like Dart should be.. D:)
class Triangle{
  final num _lengthA;
  final num _lengthB;
  final num _lengthC;
  Triangle(this._lengthA,this._lengthB,this._lengthC);
  String get triangleType{
    List<String> _result = [];
    if(_lengthA==_lengthB||_lengthB==_lengthC||_lengthA==_lengthC){
      _result.add('Isosceles');
      if(_lengthA==_lengthB&&_lengthA==_lengthC){
        _result.add('Equilateral');
      }
    }else{
      _result.add('Scalene');
    }
    return _result.join(' and ')+' Triangle';
  }
}

void main(){
  Triangle myFirstTriangle = Triangle(20,20,20);
  Triangle mySecondTriangle = Triangle(20,20,30);
  Triangle myThirdTriangle = Triangle(10,13,14);
  print(myFirstTriangle.triangleType);
  print(mySecondTriangle.triangleType);
  print(myThirdTriangle.triangleType);
}
