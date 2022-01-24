// ignore_for_file: prefer_if_null_operators

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget myDivider(){

  return  const Divider(
      height: 0,
      thickness: 1,
      indent: 20,
      endIndent: 0,
      color: Colors.black12,
  );

}


void navigateTo(BuildContext context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

Widget defaultFormField({
   int? maxLength,
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? onTap,
  Function(String)? onChanged,
  Function()? suffixPressed,
  void Function(String?)? onSave,
  Function(String)? onSubmit,
  required TextInputType type,
  required String? Function(String?) validate,
  bool isPassword = false,

}) =>
    TextFormField(
      maxLength: maxLength,
      onSaved:onSave,
      validator: validate,
      keyboardType: type,
      onTap: onTap,
      obscureText: isPassword,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border:  OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 6.0,
  required Function()? function,
  required String text,
  required BuildContext context,
}) =>
    Container(
      width: width,
      height: 55.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: Theme.of(context).textTheme.button!.copyWith(
              color: Colors.white,
            )
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function()? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}


Future showAwesomeDialog({
  required BuildContext context,
  required String body,
           String? title,
            Function? btnCancelOnPress,
            Function? btnOkOnPress,
})
{
  return AwesomeDialog(

    context: context,
    dialogType: DialogType.ERROR,
    borderSide: const BorderSide(color: Colors.red, width: 5),
    width: 430,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.TOPSLIDE,
     title: title,
    showCloseIcon: false,

    desc: body,
    btnCancelOnPress: btnCancelOnPress,
    btnOkOnPress:  btnOkOnPress,
  ).show();

}