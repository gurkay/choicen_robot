import 'package:choicen_robot/models/conclution_finish.dart';
import '../request/request_conclution_finish.dart';

import 'package:choicen_robot/utilities/i_response.dart';

abstract class CallBackConclutionFinish {
  void onSuccessDoInsertConclutionFinish(ConclutionFinish conclutionFinish);
  void onSuccessDoListConclutionFinish(List<ConclutionFinish> conclutionFinies);
  void onSuccessDoListConclutionFinishWitoutId(
      List<ConclutionFinish> conclutionFinies);
  void onSuccessDoDeleteConclutionFinish(int result);
  void onErrorConclutionFinish(String error);
}

class ResponseConclutionFinish implements IResponse {
  final CallBackConclutionFinish _callBackConclutionFinish;
  ResponseConclutionFinish(this._callBackConclutionFinish);
  RequestConclutionFinish requestConclutionFinish =
      new RequestConclutionFinish();

  @override
  doDelete(dynamic conclutionId) {
    requestConclutionFinish
        .delete(conclutionId)
        .then((value) =>
            _callBackConclutionFinish.onSuccessDoDeleteConclutionFinish(value))
        .catchError((onError) => _callBackConclutionFinish
            .onErrorConclutionFinish(onError.toString()));
  }

  @override
  doInsert(dynamic conclutionFinish) {
    requestConclutionFinish
        .insert(conclutionFinish)
        .then((value) =>
            _callBackConclutionFinish.onSuccessDoInsertConclutionFinish(value))
        .catchError((onError) => _callBackConclutionFinish
            .onErrorConclutionFinish(onError.toString()));
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

  doListConclutionFinish(dynamic conclutionId) {
    requestConclutionFinish
        .getListConclutionFinies(conclutionId)
        .then((value) =>
            _callBackConclutionFinish.onSuccessDoListConclutionFinish(value))
        .catchError((onError) => _callBackConclutionFinish
            .onErrorConclutionFinish(onError.toString()));
  }

  doListConclutionFinishWitoutId() {
    requestConclutionFinish
        .getListConclutionFiniesWitoutId()
        .then((value) => _callBackConclutionFinish
            .onSuccessDoListConclutionFinishWitoutId(value))
        .catchError((onError) => _callBackConclutionFinish
            .onErrorConclutionFinish(onError.toString()));
  }
}
