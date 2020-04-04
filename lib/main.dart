//Banks database containing all created accts both active and inactive
List<BankAccount> _bankDB = [];
BankAccount myBankAccount(String accountNumber){
  //function that checks if acct exists in DB else create new acct
  var hiddenAccNumber =  List.generate(accountNumber.length-4,(_)=>'*').join("")+accountNumber.substring(accountNumber.length-4);
    
  try{
  var x = _bankDB.firstWhere((b)=>b.accountNumber==accountNumber);
    print('Account $hiddenAccNumber active....');
    return x;
  }catch(e){
    //Error is thrown when account does not exists in database hence, 
    //a new acct is created
  _bankDB.add(BankAccount(accountNumber));
    print('Account $hiddenAccNumber active....');
  return _bankDB.last;
  }
}
class BankAccount{
  final String accountNumber;
  bool isActive=true;
  num _balance=0;
  //Constructor creates a new BankAccount if none
  BankAccount(this.accountNumber);
  
  //Balance enquiry
 void balanceEnquiry()=>print(isActive?'Account Balance: \$$_balance':'Account is either inactive or closed. Report case to the nearest XYZ Bank branch');
  
  //Withdraw
  void withdraw(num amount){
    if(!isActive){
      print('Account is either inactive or closed. Report case to the nearest XYZ Bank branch');
      return;
    }
    if(amount>_balance)print('Insufficient Balance\nOperation failed');else{
    _balance-=amount;
    print('\$$amount debited.');
    balanceEnquiry();
    }
  }
  
  //Deposit
  void deposit(num amount){
    if(!isActive){
      print('Account is either inactive or closed. Report case to the nearest XYZ Bank branch');
      return;
    }
    _balance+=amount;
    print('\$$amount deposited');
    balanceEnquiry();
  }
  ///close or disable acct
  void close(){
    isActive = false;
    print('Account $accountNumber has been closed and cannot be operated upon.');
  }
  
}




void main(){
  var myAccount = myBankAccount('1345657798');
  myAccount.balanceEnquiry();
  print('.................................');
  myAccount.deposit(10000);
  print('.................................');
  myAccount.withdraw(2000);
  print('.................................');
  myAccount.close();
  print('.................................');
  //still the same account because of unique accountNumber
  var anotherAccount = myBankAccount('1345657798');
  anotherAccount.balanceEnquiry();
}