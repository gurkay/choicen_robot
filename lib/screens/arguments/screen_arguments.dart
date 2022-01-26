import 'package:choicen_robot/models/activity.dart';
import 'package:choicen_robot/models/criteria.dart';

class ScreenArguments {
  final Function addTx;
  final List<Activity> listActivities;
  final List<Criteria> listCriterias;

  ScreenArguments({
    required this.addTx,
    required this.listActivities,
    required this.listCriterias,
  });
}
