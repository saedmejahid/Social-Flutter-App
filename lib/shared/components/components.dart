import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_project/shared/styles/colors.dart';
Widget defaulButton({
  double width = double.infinity,
  Color backround = defaultColor,
  double radius = 10.0,
  double heghit = 50.0,
  bool isUpperCase = true,
  required String text,
   required Function pressed,
}) => Container(
      height: heghit,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backround,
      ),
      child: MaterialButton(
        onPressed: () {
          pressed();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text.toLowerCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultForm({
  required TextEditingController controller,
  required TextInputType type,
  required String lapel,
  required IconData prefix,
  required Function validate,
  required Function onTap,
   Function? onChange,
  double? width = double.infinity,
  Function? onSup,
  IconData? suffix,
  Function? suffixPressed,
  bool isPassword = false,
  bool isCalickable = true,
  double radius = 10.0,
}) => SizedBox(
  width: width,
  child:   TextFormField(
        validator: (value) => validate(value),
        enabled: isCalickable,
        onChanged: (value){
          (value);
        },
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onTap: () => onTap(),
        onFieldSubmitted: (value) {
          (value);
        },
        decoration: InputDecoration(
          labelText: lapel,
          prefixIcon: Icon(
              prefix,
            color: defaultColor,
          ),
          suffixIcon: suffix != null ? IconButton(
                  icon: Icon(
                    suffix,
                  ),
                  onPressed: () => suffixPressed!(),
                ) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                radius,
            ),
          ),
        ),
      ),
);

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget> ? actions,
}) => AppBar(
  title: Text(
    title!,
  ),
  actions: actions,
);


Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1,
      color: defaultColor,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinsh(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) {
      return false;
    },
  );
}

enum ToastStates {success,errorr,warning}
Color chooseToastColor(ToastStates state)
{
  Color color;
  switch (state)
  {
    case ToastStates.success:
      color = defaultColor;
      break;
    case ToastStates.errorr:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.yellow
      ;
      break;
  }
  return color;
}

void showToast({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);


