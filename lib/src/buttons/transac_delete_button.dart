import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionDeleteButton extends StatefulWidget {
  const TransactionDeleteButton({Key key, this.page}) : super(key: key);

  final int page;

  @override
  State<StatefulWidget> createState() => _AddButtonState();
}

class _AddButtonState extends State<TransactionDeleteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 20,
        icon: Icon(Icons.do_disturb_on_outlined),
        color: Color(0xff9F4A54),
        onPressed: () => confirmationDialog(context, "Estas seguro ?",
                title: "Confirmacion",
                confirmationText: "Click here to confirmar",
                positiveText: "Delete", positiveAction: () {
              /**deleteFct**/
            }));
  }
}
