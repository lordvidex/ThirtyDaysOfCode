Map<String,bool> count = {};
bool isIsogram(String s) {
  var answer = true;
  s = s.replaceAll(new RegExp(r'\s|-'), '').toLowerCase();
  s.split('').forEach((sd){
    if(count[sd]==null)count[sd]= true;
    else answer = false;
  });
  return answer;
}

void main() {
  print(isIsogram('downstream')?'String is an Isogram':'String is NOT an Isogram');
}
