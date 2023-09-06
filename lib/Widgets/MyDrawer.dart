import 'package:flutter/material.dart';

class MyDrawer extends Drawer {
  MyDrawer({Key? key, Widget? child})
      : super(
          key: key,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff6bbd99),
                ),
                child: Center(
                  child: Text(
                    'Categories',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Category 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Category 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        );
}
