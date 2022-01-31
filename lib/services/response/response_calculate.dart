import '../../models/calculate.dart';
import '../request/request_calculate.dart';
import '../../utilities/i_response.dart';

abstract class CallBackCalculate {
  void onSuccessDoInsertCalculate(Calculate calculate);
  void onSuccessDoListCalculate(List<Calculate> calculates);
  void onSuccessDoDeleteCalculate(int result);
  void onErrorCalculate(String error);
}

class ResponseCalculate implements IResponse {
  final CallBackCalculate _callBackCalculate;
  ResponseCalculate(this._callBackCalculate);
  RequestCalculate requestCalculate = new RequestCalculate();

  @override
  doDelete(dynamic calculateId) {
    requestCalculate
        .delete(calculateId)
        .then((value) => _callBackCalculate.onSuccessDoDeleteCalculate(value))
        .catchError((onError) =>
            _callBackCalculate.onErrorCalculate(onError.toString()));
  }

  @override
  doInsert(dynamic calculate) {
    requestCalculate
        .insert(calculate)
        .then((value) => _callBackCalculate.onSuccessDoInsertCalculate(value))
        .catchError((onError) =>
            _callBackCalculate.onErrorCalculate(onError.toString()));
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

  doListCalculate(dynamic conclutionId) {
    requestCalculate
        .getListCalculates(conclutionId)
        .then((value) => _callBackCalculate.onSuccessDoListCalculate(value))
        .catchError((onError) =>
            _callBackCalculate.onErrorCalculate(onError.toString()));
  }
}
