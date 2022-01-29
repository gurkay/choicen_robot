class Calculate {
  int? _calculateId;
  int? _userId;
  String? _conclutionId;
  int? _activityId;
  int? _criteriaId;
  double? _amount;

  Calculate(
    this._userId,
    this._conclutionId,
    this._activityId,
    this._criteriaId,
    this._amount,
  );

  Calculate.withCalculateId(
    this._calculateId,
    this._userId,
    this._conclutionId,
    this._activityId,
    this._criteriaId,
    this._amount,
  );

  int get calculateId => _calculateId ?? 0;

  int get userId => _userId ?? 0;
  set userId(int newUserId) {
    if (newUserId != 0) {
      this._userId = newUserId;
    }
  }

  String get conclutionId => _conclutionId ?? '';
  set conclutionId(String newConclutionId) {
    if (newConclutionId != 0) {
      this._conclutionId = newConclutionId;
    }
  }

  int get activityId => _activityId ?? 0;
  set activityId(int newActivityId) {
    if (newActivityId != 0) {
      this._activityId = newActivityId;
    }
  }

  int get criteriaId => _criteriaId ?? 0;
  set criteriaId(int newCriteriaId) {
    if (newCriteriaId != 0) {
      this._criteriaId = newCriteriaId;
    }
  }

  double get amount => _amount ?? 0;
  set amount(double newAmount) {
    this._amount = newAmount;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_calculateId != null) {
      map['calculateId'] = _calculateId;
    }
    map['userId'] = _userId;
    map['conclutionId'] = _conclutionId;
    map['activityId'] = _activityId;
    map['criteriaId'] = _criteriaId;
    map['amount'] = _amount;
    return map;
  }

  Calculate.fromMapObject(Map<String, dynamic> map) {
    _calculateId = map['calculateId'];
    _userId = map['userId'];
    _conclutionId = map['conclutionId'];
    _activityId = map['activityId'];
    _criteriaId = map['criteriaId'];
    _amount = map['amount'];
  }
}
