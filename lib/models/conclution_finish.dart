import 'package:choicen_robot/models/activity.dart';

class ConclutionFinish {
  String? _conclutinonFinishId;
  String? _conclutionId;
  String? _activityName;
  double? _conclutionFinishValue;

  ConclutionFinish(
    this._conclutionId,
    this._activityName,
    this._conclutionFinishValue,
  );

  ConclutionFinish.withConclutionId(
    this._conclutinonFinishId,
    this._conclutionId,
    this._activityName,
    this._conclutionFinishValue,
  );

  String get conclutionFinishId => _conclutinonFinishId ?? '';

  String get conclutionId => _conclutionId ?? '';
  set conclutionId(String newConclutionId) {
    if (newConclutionId != '') {
      this._conclutionId = newConclutionId;
    }
  }

  String get activityName => _activityName ?? '';
  set activityName(String newActivityName) {
    if (activityName != '') {
      this._activityName = activityName;
    }
  }

  double get conclutionFinishValue => _conclutionFinishValue ?? 0;
  set conclutionFinishValue(double newConclutionFinishValue) {
    if (newConclutionFinishValue != 0.0) {
      this._conclutionFinishValue = newConclutionFinishValue;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_conclutinonFinishId != '') {
      map['conclutinonFinishId'] = _conclutinonFinishId;
    }
    map['conclutionId'] = _conclutionId;
    map['activityName'] = _activityName;
    map['conclutionFinishValue'] = _conclutionFinishValue;

    return map;
  }

  ConclutionFinish.fromMapObject(Map<String, dynamic> map) {
    _conclutinonFinishId = map['conclutinonFinishId'];
    _conclutionId = map['conclutionId'];
    _activityName = map['activityName'];
    _conclutionFinishValue = map['conclutionFinishValue'];
  }
}
