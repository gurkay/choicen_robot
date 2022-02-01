import '../../models/conclution.dart';
import '../request/request_conclution.dart';
import '../../utilities/i_response.dart';

abstract class CallBackConclution {
  void onSuccessDoInsertConclution(Conclution conclution);
  void onSuccessDoListConclution(List<Conclution> conclutions);
  void onSuccessDoDeleteConclution(int result);
  void onSuccessDoUpdateConclution(int result);
  void onErrorConclution(String error);
}

class ResponseConclution implements IResponse {
  final CallBackConclution _callBackConclution;
  ResponseConclution(this._callBackConclution);
  RequestConclution requestConclution = new RequestConclution();

  @override
  doDelete(dynamic conclutionId) {
    requestConclution
        .delete(conclutionId)
        .then((value) => _callBackConclution.onSuccessDoDeleteConclution(value))
        .catchError((onError) =>
            _callBackConclution.onErrorConclution(onError.toString()));
  }

  @override
  doInsert(dynamic conclution) {
    requestConclution
        .insert(conclution)
        .then((value) => _callBackConclution.onSuccessDoInsertConclution(value))
        .catchError((onError) =>
            _callBackConclution.onErrorConclution(onError.toString()));
  }

  @override
  doRead(data) {
    // TODO: implement doRead
    throw UnimplementedError();
  }

  @override
  doUpdate(dynamic conclution) {
    requestConclution
        .update(conclution)
        .then((value) => _callBackConclution.onSuccessDoUpdateConclution(value))
        .catchError((onError) =>
            _callBackConclution.onErrorConclution(onError.toString()));
  }

  doListConclution(dynamic categoryId) {
    requestConclution
        .getListConclutions(categoryId)
        .then((value) => _callBackConclution.onSuccessDoListConclution(value))
        .catchError((onError) =>
            _callBackConclution.onErrorConclution(onError.toString()));
  }
}
