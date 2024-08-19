import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgwen_scouts_5/shared/constants/colors.dart';

///UI designs
void navigateAndFinish(
    context,
    Widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context) => Widget),
      (Route<dynamic> route) => false,
);

Widget defaultFormField({
  var validator,
  required String labelText,
  required var controller,
  required var type,
  int? maxCharacters,
  bool passwordHidden = false,
  Widget? suffix,
  Widget? prefixIcon,
}) => TextFormField(
  validator: validator,
  maxLength: maxCharacters,
  controller: controller,
  keyboardType: type,
  obscureText: passwordHidden,
  decoration: InputDecoration(
        errorStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

Widget defaultDropdownList({
  required String validationMessage,
  required String hintMessage,
  required var value,
  required var items,
  required var onChanged,

}) => DropdownButtonFormField<String>(
  validator: (value){
    if (value == null){
      return '$validationMessage';
    }
    return null;
  },
  hint: Text('$hintMessage',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),),
  value: value,
  items: items,
  onChanged: onChanged,
  style: TextStyle(
    fontSize: 20,
    color: Colors.orangeAccent,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  ),
  borderRadius: BorderRadius.circular(12),
  dropdownColor: Colors.grey[700],
  alignment: Alignment.center,
  padding: EdgeInsets.all(10),
);

Widget frequentModificationButton({
  required var onPressed,
  required String textLabel,

}) => MaterialButton(
  onPressed: onPressed,
  color: Colors.blue,
  shape: CircleBorder(),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text('$textLabel',
      style: TextStyle(
          fontSize: 22,
          color: Colors.white
      ),
    ),
  ),
);


///for notification messages
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      textColor: Colors.white,
      backgroundColor: chooseToastColor(state),
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
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

  return color ;
}


///components for score board teams
Widget lionResult() => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 30,
        child: Image.asset('images/lion.png'),
        backgroundColor: Colors.yellow[700],
      ),
      SizedBox(width: 10,),
      Expanded(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.yellow[700],
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text('طليعة الأسد',
                style: TextStyle(
                  fontFamily: 'Sabah',
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
      // SizedBox(width: 10,),
    ],
  ),
);

Widget pantherResult() => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 30,
        child: Image.asset('images/panther.png'),
        backgroundColor: Colors.purple[700],
      ),
      SizedBox(width: 10,),
      Expanded(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.purple[700],
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text('طليعة الفهد',
                style: TextStyle(
                  fontFamily: 'Sabah',
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
      // SizedBox(width: 10,),

    ],
  ),
);

Widget wolfResult() => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 30,
        child: Image.asset('images/wolf.png',
        width: 50,),
        backgroundColor: Colors.red[700],
      ),
      SizedBox(width: 10,),
      Expanded(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red[700],
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text('طليعة الذئب',
                style: TextStyle(
                  fontFamily: 'Sabah',
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
      // SizedBox(width: 10,),

    ],
  ),
);

Widget tigerResult() => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 30,
        child: Image.asset('images/tiger.png'),
        backgroundColor: Colors.blue[700],
      ),
      SizedBox(width: 10,),
      Expanded(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[700],
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text('طليعة النمر',
                style: TextStyle(
                  fontFamily: 'Sabah',
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
      // SizedBox(width: 10,),

    ],
  ),
);

Widget customScore(value) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    // width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.grey[350],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('$value \$',
          style: TextStyle(
              fontSize: 20
          ),
        ),
      ),
    ),
  ),
);
