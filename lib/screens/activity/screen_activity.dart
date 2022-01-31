import '../../constants/constants.dart';
import '../../models/activity.dart';
import '../../models/category.dart';
import '../../screens/activity/components/activity_list.dart';
import '../../services/response/response_activity.dart';
import 'package:flutter/material.dart';

import 'components/new_activity.dart';

class ScreenActivity extends StatefulWidget {
  static String routeName = '/screen_activity';
  final Category category;

  ScreenActivity({
    required this.category,
  });

  @override
  _ScreenActivityState createState() => _ScreenActivityState(category);
}

class _ScreenActivityState extends State<ScreenActivity>
    implements CallBackActivity {
  Category _category;
  ResponseActivity? _responseActivity;
  _ScreenActivityState(this._category) {
    _responseActivity = ResponseActivity(this);
  }

  List<Activity> _categoryActivities = [];
  Activity _activity = new Activity(0, '');

  void _addNewActivity(String txActivityName) async {
    await _responseActivity!.doInsert(
      Activity(
        _category.categoryId,
        txActivityName,
      ),
    );

    getActivitiesList();

    final newTx = Activity.withActivityId(
      _activity.activityId,
      _category.categoryId,
      txActivityName,
    );

    setState(() {
      _categoryActivities.add(newTx);
    });
  }

  void _startAddActivity(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewActivity(_addNewActivity),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteActivity(int id) async {
    await _responseActivity!.doDelete(id);
    setState(() {
      _categoryActivities.removeWhere((activity) => activity.activityId == id);
    });
  }

  getActivitiesList() async {
    await _responseActivity!.doListActivity(_category.categoryId);
  }

  @override
  void initState() {
    getActivitiesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(cTitleScreenActivity),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActivityList(
              _categoryActivities,
              _deleteActivity,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddActivity(context),
      ),
    );
  }

  @override
  void onErrorActivity(String error) {
    print('screen_activity:::onErrorActivity:::$error');
  }

  @override
  void onSuccessDoInsertActivity(Activity activity) {
    setState(() {
      _activity = activity;
    });
  }

  @override
  void onSuccessDoListActivity(List<Activity> activities) {
    setState(() {
      _categoryActivities = activities;
    });
  }

  @override
  void onSuccessDoDeleteActivity(int result) {
    print('screen_activity:::onSuccessDoDeleteActivity:::$result');
  }
}
