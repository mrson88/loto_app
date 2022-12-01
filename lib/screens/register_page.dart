import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loto_app/screens/auth.dart';
import 'package:loto_app/utils/snackbar_helper.dart';
import 'package:loto_app/widget/constant.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = true;
  Map body = {};
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background_img/image_signup.png',
                ),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 58,
                ),
                nInputDecoration(
                    text: 'Username', obs: false, controller: userController),
                nInputDecoration(
                    text: 'Email', obs: false, controller: emailController),
                nInputDecoration(
                    text: 'First_name',
                    obs: false,
                    controller: firstnameController),
                nInputDecoration(
                    text: 'Last_name',
                    obs: false,
                    controller: lastnameController),
                nInputDecoration(
                    text: 'Password',
                    obs: true,
                    controller: password1Controller),
                nInputDecoration(
                    text: 'Verify Password',
                    obs: true,
                    controller: password2Controller),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    submitRegister();
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(8), child: Text("Register")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitRegister() async {
    final user = userController.text;
    final email = emailController.text;
    final firstname = firstnameController.text;
    final lastname = lastnameController.text;
    String password = '';
    if (password1Controller.text != password2Controller.text) {
      showDialogMassage(context, message: 'Incorrect password');
    } else {
      password = password1Controller.text;
    }

    //Get the data from form

    body = {
      "username": user,
      "email": email,
      "first_name": firstname,
      "last_name": lastname,
      "password": password
    };

    const url = 'https://mrson-routting-fastapi.onrender.com/auth/create/user';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(response.statusCode);
    print(body);
    if (response.statusCode == 200) {
      navigateToRegisterPage();
      showDialogMassage(context, message: 'Success');
    } else {
      showDialogMassage(context, message: 'Something went wrong');
    }

    //Submit data to the server
    //show success
  }

  void navigateToRegisterPage() {
    setState(() {
      isLoading = true;
    });
    final route = MaterialPageRoute(builder: (context) => AuthPage());
    Navigator.push(context, route);
  }
}
