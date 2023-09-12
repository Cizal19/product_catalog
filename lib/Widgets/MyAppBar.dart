import 'package:flutter/material.dart';
import 'package:product_catalog/Widgets/CustomSearchDelegate.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    Key? key,
    TextStyle? textStyle,
    Color? backgroundColor,
    IconThemeData? iconTheme,
    String? title,
    List<Widget>? actions,
    required BuildContext context,
  }) : super(
          key: key,
          title: Text(
            title ?? '',
            style: textStyle ?? const TextStyle(color: Colors.white),
          ),
          backgroundColor: backgroundColor ?? const Color(0xff46a094),
          iconTheme: iconTheme ?? const IconThemeData(color: Colors.white),
          actions: actions ??
              <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    showSearch(
                        context: context,
                        // delegate to customize the search bar
                        delegate: CustomSearchDelegate());
                  },
                )
              ],
        );
}
