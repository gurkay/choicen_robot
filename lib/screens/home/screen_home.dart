import '../../models/user.dart';
import '../../screens/activity/screen_activity.dart';
import '../../screens/calculate/screen_calculate.dart';
import '../../screens/criteria/screen_criteria.dart';
import '../../screens/home/components/category_list.dart';
import '../../services/response/response_category.dart';
import '../../services/response/response_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../../models/category.dart';
import 'package:flutter/material.dart';

import 'components/new_category.dart';

class ScreenHome extends StatefulWidget {
  static String routeName = '/screen_home';
  final VoidCallback signOut;
  ScreenHome({
    required this.signOut,
  });

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> implements CallBackCategory {
  ResponseCategory? _responseCategory;
  _ScreenHomeState() {
    _responseCategory = ResponseCategory(this);
  }

  List<Category> _userCategories = [];
  Category _category = Category(0, '');

  void _addNewCategory(String txCategoryName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    print('screen_home:::_addNewCategory:::txCategoryName:::${txCategoryName}');
    print(
        'screen_home:::_addNewCategory:::${sharedPreferences.getInt('userId')}');
    print(
        'screen_home:::_addNewCategory:::${sharedPreferences.getString('userEmail')}');
    print(
        'screen_home:::_addNewCategory:::${sharedPreferences.getString('userPassword')}');
    // print('screen_home:::_category!.categoryId:::${_category!.categoryId}');
    await _responseCategory!.doInsert(
      Category(
        sharedPreferences.getInt('userId'),
        txCategoryName,
      ),
    );

    getCategoryList();

    final newTx = Category.withCategoryId(
      _category.categoryId,
      sharedPreferences.getInt('userId'),
      txCategoryName,
    );

    setState(() {
      _userCategories.add(newTx);
    });
  }

  void _startAddNewCategory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewCategory(_addNewCategory),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteCategory(int id) async {
    await _responseCategory!.doDelete(id);

    setState(() {
      _userCategories.removeWhere((category) => category.categoryId == id);
    });
  }

  void _navigateButton(
    BuildContext context,
    String buttonSelected,
    Category category,
    int id,
  ) {
    switch (buttonSelected) {
      case 'Secenekler':
        Navigator.pushNamed(
          context,
          ScreenActivity.routeName,
          arguments: category,
        );
        break;
      case 'Nitelikler':
        Navigator.pushNamed(
          context,
          ScreenCriteria.routeName,
          arguments: category,
        );
        break;
      case 'Hesapla':
        Navigator.pushNamed(
          context,
          ScreenCalculate.routeName,
          arguments: category,
        );
        break;
      case 'Sil':
        _deleteCategory(id);
        break;
      default:
    }
  }

  getCategoryList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await _responseCategory!.doListCategory(sharedPreferences.getInt('userId'));
  }

  @override
  void initState() {
    getCategoryList();
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
          children: [
            CategoryList(
              _userCategories,
              _navigateButton,
              //_deleteCategory,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewCategory(context),
      ),
    );
  }

  @override
  void onErrorCategory(String error) {
    print('screen_home ::: onErrorCategory ::: $error');
  }

  @override
  void onSuccessDoInsertCategory(Category category) {
    setState(() {
      this._category = category;
    });
  }

  @override
  void onSuccessDoListCategory(List<Category> category) {
    setState(() {
      this._userCategories = category;
    });
  }

  @override
  void onSuccessDoDeleteCategory(int result) {
    print('screen_home ::: onSuccessDoDeleteCategory ::: $result');
  }
}
