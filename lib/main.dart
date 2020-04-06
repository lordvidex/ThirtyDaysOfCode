///***************append function
List<dynamic> append(List a, List b){
  return a+b;
}

///************concatenate function
class VarLists<T>{
  List<dynamic> merger(List x){
    List merges = [];
    for(var a in x)merges+=a;
    return merges;
  }
  @override
  dynamic noSuchMethod(Invocation inv){
    return merger(inv.positionalArguments);
  }
}
dynamic concatenate = VarLists();

///****************filter function

/* using iterable method
 Iterable<dynamic> filter(bool Function(dynamic) predicate, List<dynamic>list) sync*{
   for(var x in list) {
     if(predicate(x))yield x;
   }
 }
*/

//using list method
List<dynamic> filter(bool Function(dynamic) predicate, List<dynamic> list){
  List as = [];
  for(var x in list) {
    if(predicate(x))as+=[x];
  }
  return as;
}

//****************length function
int length(List list){
  var count= 0;
  for(var x in list)count++;
  return count;
}

//*****************map function
//BONUS tinz
/* using iterable method
 Iterable<dynamic> map(dynamic Function(dynamic) func, List<dynamic>list) sync*{
   for(var x in list) {
     yield(func(x));
   }
 }
 //DONT FORGET TO USE .toList() if Iterable method is preferred
*/

List<dynamic> map(dynamic Function(dynamic) func, List<dynamic> list){
  List as = [];
  for(var x in list)as+=[func(x)];
  return as;
}

//******************reverse
List<dynamic> reverse(List a){
  var count = 0;
  for(var x in a)count++;
  for(int i = 0;i<count~/2;i++){
    var temp = a[i];
    a[i] = a[-1+count-i];
    a[count-i-1] = temp;
  }
  return a;
}

void main() {
  List a = [1,2,3,4];
  List b = ['a','b','c','d'];
  
  //append
  List appended = append(a,b);
  print(appended);
  
  //concatenate
  var conc = concatenate(a,b,[1,5],[12,3456,],['a',"s",12.54,'a']);
  print(conc);
  
  //filter
  List filtered = filter((x)=>x.runtimeType==int,appended);
  print(filtered);
  
  //length
  print(length(a));
  
  //map
  List maps = map((x)=>x*x,a);
  print(maps);
  
  //reverse
  List reverser = reverse(appended);
  print(reverser);
}
