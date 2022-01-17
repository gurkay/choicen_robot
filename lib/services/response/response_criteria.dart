import 'package:choicen_robot/models/criteria.dart';
import 'package:choicen_robot/services/request/request_criteria.dart';
import 'package:choicen_robot/utilities/i_response.dart';

abstract class CallBackCriteria {
  void onSuccessDoInsertCriteria(Criteria criteria);
  void onSuccessDoListCriteria(List<Criteria> criterias);
  void onSuccessDoDeleteCriteria(int result);
  void onErrorCriteria(String error);
}

class ResponseCriteria implements IResponse {
  final CallBackCriteria _callBackCriteria;
  ResponseCriteria(this._callBackCriteria);
  RequestCriteria requestCriteria = new RequestCriteria();

  @override
  doDelete(dynamic criteriaId) {
    requestCriteria
        .delete(criteriaId)
        .then((value) => _callBackCriteria.onSuccessDoDeleteCriteria(value))
        .catchError(
            (onError) => _callBackCriteria.onErrorCriteria(onError.toString()));
  }

  @override
  doInsert(dynamic criteria) {
    requestCriteria
        .insert(criteria)
        .then((value) => _callBackCriteria.onSuccessDoInsertCriteria(value))
        .catchError(
            (onError) => _callBackCriteria.onErrorCriteria(onError.toString()));
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
    requestCriteria
        .getListCriterias(categoryId)
        .then((value) => _callBackCriteria.onSuccessDoListCriteria(value))
        .catchError(
            (onError) => _callBackCriteria.onErrorCriteria(onError.toString()));
  }
}
