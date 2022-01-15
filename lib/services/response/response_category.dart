import 'package:choicen_robot/models/category.dart';
import 'package:choicen_robot/services/request/request_category.dart';
import 'package:choicen_robot/utilities/i_response.dart';

abstract class CallBackCategory {
  void onSuccessCategory(Category category);
  void onSuccessDoListCategory(List<Category> category);
  void onErrorCategory(String error);
}

class ResponseCategory implements IResponse {
  final CallBackCategory _callBackCategory;
  ResponseCategory(this._callBackCategory);
  RequestCategory requestCategory = new RequestCategory();

  @override
  doDelete(data) {
    // TODO: implement doDelete
    throw UnimplementedError();
  }

  @override
  doInsert(dynamic category) {
    requestCategory
        .insert(category)
        .then((value) => _callBackCategory.onSuccessCategory(value))
        .catchError(
            (onError) => _callBackCategory.onErrorCategory(onError.toString()));
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

  doListCategory(dynamic userId) {
    requestCategory
        .getListCategory(userId)
        .then((value) => _callBackCategory.onSuccessDoListCategory(value))
        .catchError(
            (onError) => _callBackCategory.onErrorCategory(onError.toString()));
  }
}
