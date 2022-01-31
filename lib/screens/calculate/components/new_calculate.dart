import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../models/activity.dart';
import '../../../models/criteria.dart';
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

  final List<Widget> _listCardWidget = [];
  final List<double> _listEnteredAmount = [];

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
      }
    }
    print('new_calculate:::_submitData');
    widget.addTx(_listEnteredAmount);
    Navigator.of(context).pop();
  }

  void getList() {
    for (int i = 0, _listCount = 0; i < widget._listActivities.length; i++) {
      for (int j = 0; j < widget._listCriterias.length; j++, _listCount++) {
        _listTextEditingController.add(TextEditingController());
      }
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.80,
      child: Container(
        child: ListView.builder(
          itemCount: widget._listActivities.length,
          itemBuilder: (ctx, index) {
            for (int i = 0, _listCount = 0;
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
                      for (int j = 0;
                          j < widget._listCriterias.length;
                          j++, _listCount++)
                        RoundedInputField(
                          hintText: '${widget._listCriterias[j].criteriaName}',
                          controller: _listTextEditingController[_listCount],
                          onChanged: (_) => _submitData,
                          keyboardType: TextInputType.number,
                        ),
                      (_listCount !=
                              (widget._listActivities.length *
                                  widget._listCriterias.length))
                          ? const Text('')
                          : RoundedButton(
                              text: 'Ekle',
                              press: _submitData,
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
