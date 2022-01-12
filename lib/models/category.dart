class Category {
  int? _categoryId;
  int? _userId;
  String? _categoryName;

  Category(
    this._userId,
    this._categoryName,
  );

  Category.withCategoryId(
    this._categoryId,
    this._userId,
    this._categoryName,
  );

  int get categoryId => _categoryId ?? 0;

  int get userId => _userId ?? 0;
  set userId(int newUserId) {
    if (newUserId != 0) {
      this._userId = newUserId;
    }
  }

  String get categoryName => _categoryName ?? 'category null value return';
  set categoryName(String newCategoryName) {
    if (newCategoryName.length <= 200) {
      this._categoryName = newCategoryName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_categoryId != 0) {
      map['categoryId'] = _categoryId;
    }
    map['userId'] = _userId;
    map['categoryName'] = _categoryName;
    return map;
  }

  Category.fromMapObject(Map<String, dynamic> map) {
    _categoryId = map['categoryId'];
    _userId = map['userId'];
    _categoryName = map['categoryName'];
  }
}
