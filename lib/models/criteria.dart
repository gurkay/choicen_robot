class Criteria {
  int? _criteriaId;
  int? _categoryId;
  String? _criteriaName;
  int? _criteriaBigValuePerfect;

  Criteria(
    this._categoryId,
    this._criteriaName,
    this._criteriaBigValuePerfect,
  );

  Criteria.withCriteriaId(
    this._criteriaId,
    this._categoryId,
    this._criteriaName,
    this._criteriaBigValuePerfect,
  );

  int get criteriaId => _criteriaId ?? 0;

  int get categoryId => _categoryId ?? 0;
  set categoryId(int newCategoryId) {
    if (newCategoryId != 0) {
      this._categoryId = newCategoryId;
    }
  }

  String get criteriaName => _criteriaName ?? 'criteria null value';
  set criteriaName(String newCriteriaName) {
    if (newCriteriaName.length < 200) {
      this._criteriaName = newCriteriaName;
    }
  }

  int get criteriaBigValuePerfect => _criteriaBigValuePerfect ?? 0;
  set criteriaBigValuePerfect(int newCriteriaBigValuePerfect) {
    this._criteriaBigValuePerfect = newCriteriaBigValuePerfect;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_criteriaId != null) {
      map['criteriaId'] = _criteriaId;
    }
    map['categoryId'] = _categoryId;
    map['criteriaName'] = _criteriaName;
    map['criteriaBigValuePerfect'] = _criteriaBigValuePerfect;
    return map;
  }

  Criteria.fromMapObject(Map<String, dynamic> map) {
    _criteriaId = map['criteriaId'];
    _categoryId = map['categoryId'];
    _criteriaName = map['criteriaName'];
    _criteriaBigValuePerfect = map['criteriaBigValuePerfect'];
  }
}
