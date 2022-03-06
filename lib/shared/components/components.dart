// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, prefer_const_constructors, constant_identifier_names

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/shared/components/constants.dart';

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateNoReturn(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget DefaultFormField({
  bool isPassword = false,
  TextCapitalization capitalization = TextCapitalization.words,
  required TextInputType keyboardType,
  int maxLines = 1,
  required String label,
  IconData? prefix,
  IconData? suffix,
  double? borderRadius = 30,
  VoidCallback? onSuffixPress,
  Color color = defaultColor,
  IconData? icon,
  bool mustValidate = false,
  TextInputAction? onSubmitAction,
  // bool autoValidate = false,
  Function? onSubmit,
  ValueChanged? onChanging,
  var itemController = TextEditingController,
  VoidCallback? onTapped,
  bool readOnly = false,
}) =>
    TextFormField(
      readOnly: readOnly,
      textInputAction: onSubmitAction,
      onTap: onTapped,
      onChanged: onChanging,
      textCapitalization: capitalization,
      validator: (value) {
        if (mustValidate == true) {
          if (value == null || value.isEmpty) {
            return '$label must not be empty';
          }
          return null;
        }
      },
      controller: itemController,
      keyboardType: keyboardType,
      obscureText: isPassword,
      maxLines: maxLines,
      cursorColor: color,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: BorderSide(
              color: color,
              width: 2,
            )),
        enabledBorder: OutlineInputBorder(
          // ignore: prefer_const_constructors
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        labelText: label,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(
            prefix,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 10),
          child: IconButton(
            icon: Icon(
              suffix,
            ),
            onPressed: onSuffixPress,
          ),
        ),
      ),
      onFieldSubmitted: (s){
        onSubmit!(s);
      },
    );

Widget defaultAppBar({
  required BuildContext context,
  String? text,
  IconData? leading,
  List<Widget>? actions,
}) => AppBar(
  leading: Icon(leading,),
  title: Text(
    text!,
    style: TextStyle(
      color: defaultColor,
    ),
  ),
  actions: actions,
);

Widget DefaultButton({
  required String label,
  double borderRadius = 0,
  double width = 170,
  double height = 50,
  Color color = Colors.white,
  Color containerColor = defaultColor,
  double? fontSize,
  VoidCallback? onPress,
}) =>
    MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      height: height,
      minWidth: width,
      onPressed: onPress,
      color: containerColor,
      child: Text(
        label,
        // ignore: prefer_const_constructors
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );

Widget defaultTextButton({
  required String label,
  VoidCallback? onPress,
  TextStyle? style,
}) =>
    TextButton(
      onPressed: onPress,
      child: Text(
        label,
        style: style,
      ),
    );


void toastMsg({
  required String msg,
  required ToastStates states,
}) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: toastColor(states),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{Success, Warning, Error}

Color toastColor(ToastStates states){

  Color? color;

  switch(states){
    case ToastStates.Success:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.blueGrey;
      break;
  }

  return color;
}
