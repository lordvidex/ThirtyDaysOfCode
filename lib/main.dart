bool isPanagram(String s){
  String all = 'abcdefghijklmnopqrstuvwxyz';
  var new_s = s.replaceAll(' ','').toLowerCase();
  for(var i = 0;i<all.length;i++){
    if(!new_s.contains(all[i])){
      return false;
    }
  }
  return true;
}
void main(){
  String s = 'The quick brown fox jumps over the lazy dog';
  print(isPanagram(s));
}