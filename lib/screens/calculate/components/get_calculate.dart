import 'dart:math';

import 'package:choicen_robot/models/criteria.dart';

class GetCalculate {
  final int row;
  final int col;
  final List<double> listEnteredAmount;
  List<Criteria> listCriterias;

  GetCalculate({
    required this.row,
    required this.col,
    required this.listEnteredAmount,
    required this.listCriterias,
  });

  double avaregeGeneralTotalUtilityValue(List<double> value) {
    double calculate = 0.0;

    for (var i = 0; i < row; i++) {
      calculate = calculate + value[i];
    }

    return calculate / row;
  }

  List<double> generalTotalUtilityValue() {
    var arr = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );

    for (int i = 0, _listCount = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++, _listCount++) {
        arr[i][j] = listEnteredAmount[_listCount];
      }
    }

    List<double> bestValue = List<double>.filled(
      this.col,
      0.0,
      growable: false,
    );

    List<double> betterValue = List<double>.filled(
      this.col,
      0.0,
      growable: false,
    );

    for (int i = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++) {
        if (listCriterias[j].criteriaBigValuePerfect == 1) {
          if (betterValue[j] == 0.0) {
            betterValue[j] = arr[i][j];
          }
          if (arr[i][j] < betterValue[j]) {
            betterValue[j] = arr[i][j];
          }
          if (arr[i][j] > bestValue[j]) {
            bestValue[j] = arr[i][j];
          }
        } else {
          if (bestValue[j] == 0.0) {
            bestValue[j] = arr[i][j];
          }
          if (arr[i][j] < bestValue[j]) {
            bestValue[j] = arr[i][j];
          }
          if (arr[i][j] > betterValue[j]) {
            betterValue[j] = arr[i][j];
          }
        }
      }
    }

    List<double> calculateEntropiValue = List<double>.filled(
      this.col,
      0.0,
      growable: false,
    );
    for (int i = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++) {
        calculateEntropiValue[j] = (calculateEntropiValue[j] + arr[i][j]);
      }
    }

    var calculateNormalizeEntropiValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++) {
        calculateNormalizeEntropiValue[i][j] =
            (arr[i][j] / calculateEntropiValue[j]);
      }
    }

    var calculateLogEntropiValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++) {
        calculateLogEntropiValue[i][j] = (calculateNormalizeEntropiValue[i][j] *
            log(calculateNormalizeEntropiValue[i][j]));
      }
    }

    List<double> totalLogEntropiValue = List<double>.filled(
      this.col,
      0.0,
      growable: false,
    );
    for (int i = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++) {
        totalLogEntropiValue[j] =
            (totalLogEntropiValue[j] + calculateLogEntropiValue[i][j]);
      }
    }

    double activitiesLogValue = (1 / log(row));

    List<double> entropiValue = List<double>.filled(
      this.col,
      0.0,
      growable: false,
    );
    for (int j = 0; j < this.col; j++) {
      entropiValue[j] = double.parse(
          (activitiesLogValue * totalLogEntropiValue[j] * (-1))
              .toStringAsFixed(4));
    }

    List<double> oneEntropiValue = List<double>.filled(
      this.col,
      0.0,
      growable: false,
    );
    for (int j = 0; j < this.col; j++) {
      oneEntropiValue[j] =
          double.parse((1 - entropiValue[j]).toStringAsFixed(4));
    }

    double totalOneEntropiValue = 0.0;
    for (int j = 0; j < this.col; j++) {
      totalOneEntropiValue = double.parse(
          (totalOneEntropiValue + oneEntropiValue[j]).toStringAsFixed(4));
    }

    List<double> entropiWeightValue = List<double>.filled(
      this.col,
      0.0,
      growable: false,
    );
    for (int j = 0; j < this.col; j++) {
      entropiWeightValue[j] = double.parse(
          (oneEntropiValue[j] / totalOneEntropiValue).toStringAsFixed(4));
    }

    var arrayBetterValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++) {
        arrayBetterValue[i][j] =
            double.parse((arr[i][j] - betterValue[j]).toStringAsFixed(4));
      }
    }

    List<double> arrayBestValue = List<double>.filled(
      this.col,
      0.0,
      growable: false,
    );
    for (int j = 0; j < this.col; j++) {
      arrayBestValue[j] =
          double.parse((bestValue[j] - betterValue[j]).toStringAsFixed(4));
    }

    var normalizedUtilityValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++) {
        normalizedUtilityValue[i][j] = double.parse(
            (arrayBetterValue[i][j] / arrayBestValue[j]).toStringAsFixed(4));
      }
    }

    var totalUtilityValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++) {
        totalUtilityValue[i][j] = double.parse(
            (normalizedUtilityValue[i][j] * entropiWeightValue[j])
                .toStringAsFixed(4));
      }
    }

    List<double> generalTotalUtilityValue = List<double>.filled(
      this.row,
      0.0,
      growable: false,
    );

    for (int i = 0; i < this.row; i++) {
      for (int j = 0; j < this.col; j++) {
        generalTotalUtilityValue[i] = double.parse(
            (generalTotalUtilityValue[i] + totalUtilityValue[i][j])
                .toStringAsFixed(3));
      }
    }

    return generalTotalUtilityValue;
  }
}
