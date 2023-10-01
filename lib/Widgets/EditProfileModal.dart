import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_catalog/Screens/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileModal extends StatefulWidget {
  @override
  _EditProfileModalState createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future save(String userName, String email) async {
    try {
      var sharedPref = await SharedPreferences.getInstance();
      var userId = sharedPref.getString(SpalshScreenState.USERID);
      var res = await http.put(Uri.parse("http://localhost:8000/$userId"),
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: <String, String>{
            'userName': userName,
            'email': email,
          });
      // print(res.body);
      final data = json.decode(res.body);

      if (res.statusCode == 200) {
        await Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: 'Success',
          message: 'Details Updated Successfully',
          duration: Duration(seconds: 3),
          backgroundColor: Color(0xff46a096),
        ).show(context);
        // Navigator.pop(
        //     context, {"username": data["userName"], "email": data["email"]});
        Navigator.pushReplacementNamed(context, "/user");
      } else {
        await Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: 'Error',
          message: data["error"],
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ).show(context);
      }

      // success toast or failure toast
      // check for existing email
      //
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                save(_usernameController.text, _emailController.text);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Color(0xff46a096)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
