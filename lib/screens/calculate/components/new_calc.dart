import 'package:choicen_robot/components/rounded_button.dart';
import 'package:choicen_robot/components/rounded_input_field.dart';
import 'package:choicen_robot/models/activity.dart';
import 'package:choicen_robot/models/criteria.dart';
import 'package:choicen_robot/screens/arguments/screen_arguments.dart';
import 'package:choicen_robot/screens/calculate/components/get_calculate.dart';
import 'package:flutter/material.dart';

class NewCalc extends StatefulWidget {
  static String routeName = '/new_calc';
  final ScreenArguments screenArguments;

  NewCalc({required this.screenArguments});

  @override
  _NewCalcState createState() => _NewCalcState();
}

class _NewCalcState extends State<NewCalc> {
  final List<TextEditingController> _listTextEditingController = [];
  final _controllerActivityName = TextEditingController();
  final List<Widget> _listCardWidget = [];
  final List<double> _listEnteredAmount = [];

  void _submitData() {
    for (int i = 0, _listCount = 0;
        i < widget.screenArguments.listActivities.length;
        i++) {
      for (int j = 0;
          j < widget.screenArguments.listCriterias.length;
          j++, _listCount++) {
        if (_listTextEditingController[_listCount].text.isEmpty) {
          return;
        }
      }
    }

    for (int i = 0, _listCount = 0;
        i < widget.screenArguments.listActivities.length;
        i++) {
      for (int j = 0;
          j < widget.screenArguments.listCriterias.length;
          j++, _listCount++) {
        _listEnteredAmount
            .add(double.parse(_listTextEditingController[_listCount].text));
      }
    }

    widget.screenArguments.addTx(_listEnteredAmount);
    Navigator.of(context).pop();
  }

  void getList() {
    for (int i = 0, _listCount = 0;
        i < widget.screenArguments.listActivities.length;
        i++) {
      for (int j = 0;
          j < widget.screenArguments.listCriterias.length;
          j++, _listCount++) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('veri girisi'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 0.80,
          child: Container(
            child: ListView.builder(
              itemCount: widget.screenArguments.listActivities.length,
              itemBuilder: (ctx, index) {
                for (int i = 0, _listCount = 0;
                    i < widget.screenArguments.listActivities.length;
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
                                  widget.screenArguments.listActivities[i]
                                      .activityName,
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
                          for (int j = 0;
                              j < widget.screenArguments.listCriterias.length;
                              j++, _listCount++)
                            RoundedInputField(
                              hintText:
                                  '${widget.screenArguments.listCriterias[j].criteriaName} index ::: $_listCount',
                              controller:
                                  _listTextEditingController[_listCount],
                              onChanged: (_) => _submitData,
                              keyboardType: TextInputType.number,
                            ),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                            indent: 10,
                            endIndent: 10,
                            height: 10,
                          ),
                          Text('index ::: $_listCount'),
                        ],
                      ),
                    ),
                  );
                }

                return _listCardWidget[index];
              },
            ),
          ),
        ),
      ),
    );
  }
}
