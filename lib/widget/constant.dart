import 'package:flutter/material.dart';
import 'package:loto_app/themes/app_color.dart';

class nInputDecoration extends StatelessWidget {
  const nInputDecoration({
    required this.text,
    required this.obs,
    required this.controller,
  });
  final String text;
  final bool obs;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        style: TextStyle(color: Colors.black, fontSize: 20),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        maxLength: 30,
        textAlign: TextAlign.start,
        obscureText: obs,

        // onChanged: (value) {
        //   //Do something with the user input.
        //
        // },
        decoration: InputDecoration(
          filled: true,
          // fillColor: AppColors.lightBlueGrey,
          hintText: text,
          hintStyle: const TextStyle(color: AppColors.white),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}
