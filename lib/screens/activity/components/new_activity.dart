import 'package:choicen_robot/components/rounded_button.dart';
import 'package:choicen_robot/components/rounded_input_field.dart';
import 'package:flutter/material.dart';

class NewActivity extends StatefulWidget {
  final Function addTx;
  NewActivity(this.addTx);

  @override
  State<NewActivity> createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  final _controllerActivityName = TextEditingController();

  void _submitData() {
    if (_controllerActivityName.text.isEmpty) {
      return;
    }
    final enteredActivityName = _controllerActivityName.text;

    if (enteredActivityName.isEmpty) {
      return;
    }

    widget.addTx(enteredActivityName);
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
                hintText: 'Secenek Giriniz',
                controller: _controllerActivityName,
                onChanged: (_) => _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
