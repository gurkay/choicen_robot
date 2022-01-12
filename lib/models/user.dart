class User{
  int? _userId;
  String? _userEmail;
  String? _userPassword;
  
  User(
    this._userEmail,
    this._userPassword,
  );
  
  User.withUserId(
    this._userId,
    this._userEmail,
    this._userPassword,
  );
  
  int get userId => _userId!;
  
  set userEmail(String newUserEmail){
    if(newUserEmail.length <= 200){
      this._userEmail = newUserEmail;
    }
  }
  
  String get userEmail => _userEmail!;
  
  set userPassword(String newUserPassword){
    if(newUserPassword.length <= 200){
      this._userPassword = newUserPassword;
    }
  }
  
  String get userPassword => _userPassword;
}
