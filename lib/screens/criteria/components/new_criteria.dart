import 'package:choicen_robot/components/rounded_button.dart';
import 'package:choicen_robot/components/rounded_input_field.dart';
import 'package:flutter/material.dart';

class NewCriteria extends StatefulWidget {
  final Function addTx;
  NewCriteria(this.addTx);

  @override
  _NewCriteriaState createState() => _NewCriteriaState();
}

class _NewCriteriaState extends State<NewCriteria> {
  final _controllerCriteriaName = TextEditingController();
  final List<String> _bigValuePerfect = ['Evet', 'Hayir'];
  String _dropDownValue = '';

  void _submitData() {
    if (_controllerCriteriaName.text.isEmpty) {
      return;
    }
    final enteredCriteriaName = _controllerCriteriaName.text;
    if (enteredCriteriaName.isEmpty) {
      return;
    }
    widget.addTx(enteredCriteriaName);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedInputField(
                hintText: 'Kriter Giriniz',
                controller: _controllerCriteriaName,
                onChanged: (_) => _submitData,
              ),
              Text('Degerin Yuksek Olmasi Iyidir:'),
              DropdownButton(
                items: _bigValuePerfect
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _dropDownValue = newValue!;
                  });
                },
              ),
              RoundedButton(
                text: 'Ekle',
                press: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
