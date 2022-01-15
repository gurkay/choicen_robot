import 'package:choicen_robot/models/user.dart';
import 'package:choicen_robot/services/response/response_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../../models/category.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  static String routeName = '/screen_home';
  final VoidCallback signOut;
  ScreenHome({
    required this.signOut,
  });

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> implements CallBackUser {
  ResponseUser? _responseUser;
  _ScreenHomeState() {
    _responseUser = new ResponseUser(this);
  }

  final List<Category> _userCategories = [];
  User _user = new User('_userEmail', '_userPassword');

  void _addNewCategory(String txCategoryName) {
    final newTx = Category(_user.userId, txCategoryName);
    print('screen_home:::_userCategories:::userId:::${_user.userId}');
    setState(() {
      _userCategories.add(newTx);
    });
  }

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await _responseUser!.doRead(User(sharedPreferences.getString('userEmail'),
        sharedPreferences.getString('password')));
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(cTitleScreenHome),
        actions: [
          IconButton(
            onPressed: () {
              widget.signOut();
            },
            icon: const Icon(Icons.exit_to_app_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  @override
  void onUserError(String error) {
    print('onLoginError ::: $error');
  }

  @override
  void onUserSuccess(User user) {
    setState(() {
      this._user = user;
    });
  }
}
