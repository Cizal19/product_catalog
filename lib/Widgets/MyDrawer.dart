import 'package:flutter/material.dart';
import 'package:product_catalog/Screens/SplashScreen.dart';

import 'package:product_catalog/models/products.api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> getCategories() async {
  List productList = await ProductsApi.getProducts();

  List<String> categories = [];
  for (var product in productList) {
    String category = product.category;
    if (!categories.contains(category)) {
      categories.add(category);
    }
  }

  return categories;
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String username = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    getCategories();
    fetchUserData();
  }

  fetchUserData() async {
    try {
      var sharedPref = await SharedPreferences.getInstance();
      var userId = sharedPref.getString(SpalshScreenState.USERID);
      var res = await http.get(Uri.parse("http://localhost:8000/$userId"));
      // print(res.body);
      final data = json.decode(res.body);
      // print(data);
      setState(() {
        username = data["userName"];
        email = data["email"];
      });
    } catch (error) {
      // print("from here");
      // print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: ListView(
          shrinkWrap: true,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/user");
              },
              child: UserAccountsDrawerHeader(
                accountName: Text(username),
                accountEmail: Text(email),
                decoration: BoxDecoration(
                  color: Color(0xff6bbd99),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
              ),
            ),
            FutureBuilder<List<String>>(
              future: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No categories available.'));
                } else {
                  List<String> categories = snapshot.data!;

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true, //important!!
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(categories[index].toUpperCase()),
                          onTap: () {
                            Navigator.pushNamed(context, "/category",
                                arguments: categories[index]);
                          });
                    },
                  );
                }
              },
            ),
            // Spacer(),
            ElevatedButton(
                onPressed: () async {
                  var sharedPref = await SharedPreferences.getInstance();
                  sharedPref.setBool(SpalshScreenState.KEYLOGIN, false);
                  sharedPref.setString(SpalshScreenState.USERID, "");
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
          ]),
    ));
  }
}









            





            // FutureBuilder<User>(
            //   future: fetchUserData(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       // While data is being fetched, display a loading indicator
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       // If there's an error, display an error message
            //       return Text('Error: ${snapshot.error}');
            //     } else {
            //       // If data is successfully fetched, build the UI
            //       final userData = snapshot.data;
            //       return InkWell(
            //         onTap: () {
            //           Navigator.pushNamed(context, "/user");
            //         },
            //         child: UserAccountsDrawerHeader(
            //           accountName: Text(
            //             userData!.userName,
            //             style: TextStyle(color: Colors.white),
            //           ),
            //           accountEmail: Text(userData.email),
            //           decoration: BoxDecoration(
            //             color: Color(0xff6bbd99),
            //           ),
            //           currentAccountPicture: CircleAvatar(
            //             backgroundColor: Colors.white,
            //             child: Icon(Icons.person),
            //           ),
            //         ),
            //       );
            //     }
            //   },
            // ),