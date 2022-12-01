import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loto_app/screens/register_page.dart';
import 'package:loto_app/screens/todo_list.dart';
import 'package:loto_app/utils/snackbar_helper.dart';
import 'package:loto_app/widget/constant.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = true;
  String userToken = '';
  List items = [];
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background_img/image_login.png',
                ),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                nInputDecoration(
                    text: 'Email', obs: false, controller: userController),
                nInputDecoration(
                    text: 'Password',
                    obs: true,
                    controller: passwordController),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    submitLogin();
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(8), child: Text("Login")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      navigateToRegisterPage();
                    },
                    child: const Padding(
                        padding: EdgeInsets.all(8), child: Text("Register")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> submitLogin() async {
    final username = userController.text;
    final password = passwordController.text;
    var map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;

    //Get the data from form

    // const url = 'https://mrson-routting-fastapi.onrender.com/auth/token';
    const url = 'http://14.225.44.29/auth/token';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: map);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      debugPrint(json['token']);
      userToken = json['token'];
      navigateToAddPage();
      showDialogMassage(context, message: 'Success');
    } else {
      showDialogMassage(context, message: 'Something went wrong');
    }

    //Submit data to the server
    //show success
    return userToken;
  }

  void navigateToAddPage() {
    setState(() {
      isLoading = true;
    });
    final route = MaterialPageRoute(
        builder: (context) => TodoListPage(userToken: userToken));
    Navigator.push(context, route);
  }

  void navigateToRegisterPage() {
    setState(() {
      isLoading = true;
    });
    final route = MaterialPageRoute(builder: (context) => RegisterPage());
    Navigator.push(context, route);
  }
}
