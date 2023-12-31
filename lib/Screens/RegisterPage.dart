import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_catalog/models/User.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  FToast? successToast;
  FToast? errorToast;

  showSuccessToast(String message) {
    Widget toast;
    toast = Container(
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
      var res = await http.post(Uri.parse("http://localhost:8000/register"),
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: <String, String>{
            'userName': user.userName,
            'email': user.email,
            'password': user.password,
            'confirmPassword': user.confirmPassword
          });
      // print(res.body);
      final decodedResponse = json.decode(res.body);
      if (res.statusCode == 201) {
        // The request was successful (status code 200)
        showSuccessToast("User Created Successfully");
        Navigator.popAndPushNamed(context, "/");
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
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                "Register",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Create your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 35),
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
                  helperStyle: const TextStyle(color: Colors.white),
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
                controller: TextEditingController(text: user.email),
                onChanged: (value) {
                  user.email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Email";
                  } else if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return null;
                  } else {
                    return "Please enter valid email";
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
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
                    suffixIcon: Tooltip(
                      message:
                          "At least 8 characters, a special character, a number, and an uppercase letter",
                      triggerMode: TooltipTriggerMode.tap,
                      child: Icon(Icons.help_outline),
                      preferBelow: true,
                      showDuration: Duration(seconds: 10),
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                  controller: TextEditingController(text: user.confirmPassword),
                  onChanged: (value) {
                    user.confirmPassword = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Confirm Password";
                    } else if (user.password != user.confirmPassword) {
                      return "Password and Confirm Password do not match";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: const Icon(Icons.password_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
              const SizedBox(height: 50),
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
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Color(0xff46a094)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () =>
                            Navigator.popAndPushNamed(context, "/login"),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Color(0xff46a094)),
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
