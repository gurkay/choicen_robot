import 'package:choicen_robot/components/rounded_button.dart';
import 'package:choicen_robot/components/rounded_input_field.dart';
import 'package:choicen_robot/models/activity.dart';
import 'package:choicen_robot/models/criteria.dart';
import 'package:choicen_robot/screens/calculate/components/get_calculate.dart';
import 'package:flutter/material.dart';

class NewCalculate extends StatefulWidget {
  final Function addTx;
  final List<Activity> _listActivities;
  final List<Criteria> _listCriterias;

  NewCalculate(this.addTx, this._listActivities, this._listCriterias);

  @override
  _NewCalculateState createState() => _NewCalculateState();
}

class _NewCalculateState extends State<NewCalculate> {
  final List<TextEditingController> _listTextEditingController = [];
  List<double> _listEnteredAmount = [];
  List<Widget> _listCardWidget = [];

  void _submitData() {
    for (int i = 0, _listCount = 0; i < widget._listActivities.length; i++) {
      for (int j = 0; j < widget._listCriterias.length; j++, _listCount++) {
        if (_listTextEditingController[_listCount].text.isEmpty) {
          return;
        }
      }
    }

    for (int i = 0, _listCount = 0; i < widget._listActivities.length; i++) {
      for (int j = 0; j < widget._listCriterias.length; j++, _listCount++) {
        _listEnteredAmount
            .add(double.parse(_listTextEditingController[_listCount].text));
        if (_listEnteredAmount[_listCount].isNaN) {
          return;
        }
      }
    }

    widget.addTx(_listEnteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.80,
        child: ListView.builder(
          itemCount: widget._listActivities.length,
          itemBuilder: (ctx, index) {
            for (var i = 0, _listCount = 0;
                i < widget._listActivities.length;
                i++) {
              _listCardWidget.add(
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 1.0,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.purple[400],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget._listActivities[i].activityName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                        height: 10,
                      ),
                      for (var j = 0;
                          j < widget._listCriterias.length;
                          j++, _listCount++)
                        RoundedInputField(
                          hintText: '${widget._listCriterias[j].criteriaName} ',
                          //controller: _listTextEditingController[index],
                          onChanged: (_) => _submitData,
                        ),
                      const Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }
            return _listCardWidget[index];
          },
        ),
      ),
    );
  }
}
