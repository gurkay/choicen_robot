class Conclution {
  String? _conclutinonId;
  int? _categoryId;
  String? _conclutionName;
  DateTime? _conclutionDate;

  Conclution(
    this._categoryId,
    this._conclutionName,
    this._conclutionDate,
  );

  Conclution.withConclutionId(
    this._conclutinonId,
    this._categoryId,
    this._conclutionName,
    this._conclutionDate,
  );

  String get conclutionId => _conclutinonId ?? '';

  int get categoryId => _categoryId ?? 0;
  set categoryId(int newCategoryId) {
    if (newCategoryId != 0) {
      this._categoryId = newCategoryId;
    }
  }

  String get conclutionName => _conclutionName ?? '';
  set conclutionName(String newConclutionName) {
    if (newConclutionName != '') {
      this._conclutionName = newConclutionName;
    }
  }

  DateTime get conclutionDate => _conclutionDate ?? DateTime(1982);
  set conclutionDate(DateTime newConclutionDate) {
    if (newConclutionDate != '') {
      this._conclutionDate = newConclutionDate;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_conclutinonId != null) {
      map['conclutionId'] = _conclutinonId;
    }
    map['categoryId'] = _categoryId;
    map['conclutionName'] = _conclutionName;
    map['conclutionDate'] = _conclutionDate;
    return map;
  }

  Conclution.fromMapObject(Map<String, dynamic> map) {
    _conclutinonId = map['conclutionId'];
    _categoryId = map['categoryId'];
    _conclutionName = map['conclutionName'];
    _conclutionDate = map['conclutionDate'];
  }
}
