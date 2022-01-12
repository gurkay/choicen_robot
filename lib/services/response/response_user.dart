import 'package:choicen_robot/services/request/request_user.dart';

import '../../utilities/i_response.dart';

import '../../models/user.dart';

abstract class CallBackUser {
  void onUserSuccess(User user);
  void onUserError(String error);
}

class ResponseUser implements IResponse {
  final CallBackUser _callBackUser;
  ResponseUser(this._callBackUser);
  RequestUser requestUser = new RequestUser();

  @override
  doDelete(data) {
    // TODO: implement doDelete
    throw UnimplementedError();
  }

  @override
  doInsert(data) {
    // TODO: implement doInsert
    throw UnimplementedError();
  }

  @override
  doRead(dynamic findUser) {
    requestUser
        .read(findUser)
        .then((value) => _callBackUser.onUserSuccess(findUser))
        .catchError((onError) => _callBackUser.onUserError(onError.toString()));
  }

  @override
  doUpdate(data) {
    // TODO: implement doUpdate
    throw UnimplementedError();
  }
}
