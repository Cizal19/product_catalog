import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_catalog/models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:product_catalog/Screens/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  FToast? successToast;
  FToast? errorToast;

  showSuccessToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.green,
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );

    successToast?.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
    );
  }

  showErrorToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );

    errorToast?.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
    );
  }

  @override
  void initState() {
    super.initState();
    successToast = FToast();
    successToast?.init(context);
    errorToast = FToast();
    errorToast?.init(context);
  }

  Future save() async {
    try {
      var res = await http.post(Uri.parse("http://localhost:8000/login"),
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: <String, String>{
            'userName': user.userName,
            'password': user.password
          });
      // print(res.body);
      final decodedResponse = json.decode(res.body);
      var sharedPref = await SharedPreferences.getInstance();

      if (res.statusCode == 200) {
        // The request was successful (status code 200)
        showSuccessToast("Successfully Logged In");
        sharedPref.setBool(SpalshScreenState.KEYLOGIN, true);
        sharedPref.setString(SpalshScreenState.USERID, decodedResponse["_id"]);
        Navigator.pushReplacementNamed(context, "/homepage");
      } else {
        // Handle error status codes as needed
        showErrorToast(decodedResponse["error"]);
      }
    } catch (error) {
      print(error);
    }
  }

  User user = User("", "", "", "", "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text(
                "Welcome back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: TextEditingController(text: user.userName),
                onChanged: (value) {
                  user.userName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Username";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: TextEditingController(text: user.password),
                onChanged: (value) {
                  user.password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Password";
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        save();
                      } else {
                        return;
                      }
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/register");
                        },
                        child: Text(
                          "Signup",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
