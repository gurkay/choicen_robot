import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import 'package:flutter/material.dart';

class NewCategory extends StatefulWidget {
  final Function addTx;

  NewCategory(this.addTx);

  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  final _controllerCategoryName = TextEditingController();

  void _submitData() {
    if (_controllerCategoryName.text.isEmpty) {
      return;
    }

    final enteredCategoryName = _controllerCategoryName.text;

    if (enteredCategoryName.isEmpty) {
      return;
    }

    widget.addTx(
      enteredCategoryName,
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
                hintText: 'Kategori',
                controller: _controllerCategoryName,
                onChanged: (_) => _submitData,
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
