void countTheWord(String s){
  Map<String,int>answer = {};
  //first replace all space related symbols or unicodes to ' '
  //for uniformity
  var myString = s.toLowerCase().replaceAll(new RegExp(r'\\t|\\n'),' ');
  //Regular expression that matches all required words and adds them to  map
  var sh = RegExp(r"(\w+'\w+)|(\w+)").
    allMatches(myString).map((m)=>m[0]).forEach((f){
    answer[f]==null?
      answer[f]=1:
    answer[f]+=1;
  });
  
  //Output
  answer.forEach((k,v)=>print('$k: $v'));
  
}
void main() {
  var s = "\"That's the password: 'PASSWORD 123'!\", cried the Special Agent.\nSo I fled.";
  countTheWord(s);
  
}