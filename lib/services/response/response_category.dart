import '../../models/category.dart';
import '../../services/request/request_category.dart';
import '../../utilities/i_response.dart';

abstract class CallBackCategory {
  void onSuccessDoInsertCategory(Category category);
  void onSuccessDoListCategory(List<Category> category);
  void onSuccessDoDeleteCategory(int result);
  void onErrorCategory(String error);
}

class ResponseCategory implements IResponse {
  final CallBackCategory _callBackCategory;
  ResponseCategory(this._callBackCategory);
  RequestCategory requestCategory = new RequestCategory();

  @override
  doDelete(dynamic categoryId) {
    requestCategory
        .delete(categoryId)
        .then((value) => _callBackCategory.onSuccessDoDeleteCategory(value))
        .catchError(
            (onError) => _callBackCategory.onErrorCategory(onError.toString()));
  }

  @override
  doInsert(dynamic category) {
    requestCategory
        .insert(category)
        .then((value) => _callBackCategory.onSuccessDoInsertCategory(value))
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
