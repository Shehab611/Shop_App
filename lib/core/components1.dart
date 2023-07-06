import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defulttextformfieled({
  required label,
  required controller,
  required type,
  required prefix,
  onSubmit,
  onChange,
  required validate,
  onTap,
  suffixPressed,
  suffix,
  isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: suffixPressed,
            child: Icon(
              suffix,
            ),
          ),
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(prefix)),
    );
Widget buildArticleItem({required article, required context}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image:
                    NetworkImage(article['urlToImage'].toString(), scale: 1.0),
                fit: BoxFit.cover,
              ),
            ),
            height: 120,
            width: 120,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    article['title'].toString(),
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                  Text(article['publishedAt'].toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey))
                ],
              ),
            ),
          )
        ],
      ),
    );
Widget myDivder() => Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        color: Colors.grey[300],
        height: 1.5,
        width: double.infinity,
      ),
    );
Widget articleBuilder(list) => ConditionalBuilder(
    condition: list!.isNotEmpty,
    builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleItem(article: list[index], context: context),
        separatorBuilder: (context, index) => myDivder(),
        itemCount: 10),
    fallback: (context) => const Center(child: CircularProgressIndicator()));
Widget btn({background = Colors.blue, required text, required onPress}) =>
    ElevatedButton(
      onPressed: onPress,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
Future<dynamic> navigatto({required context, required Widget screen}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
Future<dynamic>navigatandfinsh({required context, required Widget screen}) =>
    Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(
      builder: (context) => screen,
    ), (route) => false);
void showToast({required String message, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16,
        backgroundColor: buildToastColor(state));

enum ToastState { success, warning, error }

Color buildToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
