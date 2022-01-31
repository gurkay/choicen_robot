import '../../models/activity.dart';
import '../../services/request/request_activity.dart';
import '../../utilities/i_response.dart';

abstract class CallBackActivity {
  void onSuccessDoInsertActivity(Activity activity);
  void onSuccessDoListActivity(List<Activity> activities);
  void onSuccessDoDeleteActivity(int result);
  void onErrorActivity(String error);
}

class ResponseActivity implements IResponse {
  final CallBackActivity _callBackActivity;
  ResponseActivity(this._callBackActivity);
  RequestActivity requestActivity = new RequestActivity();

  @override
  doDelete(dynamic activityId) {
    requestActivity
        .delete(activityId)
        .then((value) => _callBackActivity.onSuccessDoDeleteActivity(value))
        .catchError(
            (onError) => _callBackActivity.onErrorActivity(onError.toString()));
  }

  @override
  doInsert(dynamic activity) {
    requestActivity
        .insert(activity)
        .then((value) => _callBackActivity.onSuccessDoInsertActivity(value))
        .catchError(
            (onError) => _callBackActivity.onErrorActivity(onError.toString()));
  }

  @override
  doRead(data) {
    // TODO: implement doRead
    throw UnimplementedError();
  }

  @override
  doUpdate(data) {
    // TODO: implement doUpdate
    throw UnimplementedError();
  }

  doListActivity(dynamic categoryId) {
    requestActivity
        .getListActivities(categoryId)
        .then((value) => _callBackActivity.onSuccessDoListActivity(value))
        .catchError(
            (onError) => _callBackActivity.onErrorActivity(onError.toString()));
  }
}
