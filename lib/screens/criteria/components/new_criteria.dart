import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
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
  final Map<String, int> _mapBigValuePerfect = {
    'Evet': 1,
    'Hayir': 0,
  };
  String _dropDownValue = 'Evet';

  void _submitData() {
    if (_controllerCriteriaName.text.isEmpty) {
      return;
    }
    final enteredCriteriaName = _controllerCriteriaName.text;
    final enteredBigValuePerfect = _mapBigValuePerfect[_dropDownValue];
    if (enteredCriteriaName.isEmpty) {
      return;
    }
    widget.addTx(
      enteredCriteriaName,
      enteredBigValuePerfect,
    );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Degerin Yuksek Olmasi Iyidir : '),
                  DropdownButton(
                    value: _dropDownValue,
                    items: _bigValuePerfect.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropDownValue = newValue!;
                      });
                    },
                  ),
                ],
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
