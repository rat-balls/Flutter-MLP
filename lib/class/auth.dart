import 'package:flutter/foundation.dart';
import 'package:flutter_mlp/class/users/user.dart';

class UserProvider extends ChangeNotifier{
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
