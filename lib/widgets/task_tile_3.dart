import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// ignore: must_be_immutable
class TaskTile extends StatelessWidget {
  final String? text;
  final bool? isChecked;
  final Function? callBack;

  const TaskTile(
      {Key? key,
      @required this.text,
      @required this.isChecked,
      @required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
          color: Colors.white),
      child: ListTile(
        dense: true,
        title: Text(
          text!,
          // convet _isChecked to a none-nullable type
          style: isChecked!
              ? const TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.lineThrough)
              : const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
        ),
        // passing a voidCallBack
        trailing: Checkbox(
          value: isChecked,
          onChanged: (bool? value) => callBack!(value),
        ),
      ),
    );
  }
}
