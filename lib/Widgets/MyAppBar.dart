import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    Key? key,
    TextStyle? textStyle,
    Color? backgroundColor,
    IconThemeData? iconTheme,
    String? title,
    List<Widget>? actions,
  }) : super(
          key: key,
          title: Text(
            title ?? '',
            style: textStyle ?? TextStyle(color: Colors.white),
          ),
          backgroundColor: backgroundColor ?? Color(0xff46a094),
          iconTheme: iconTheme ?? IconThemeData(color: Colors.white),
          actions: actions ??
              <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    // do something
                  },
                )
              ],
        );
}
