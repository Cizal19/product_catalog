import 'package:flutter/material.dart';
import 'package:product_catalog/Widgets/MyAppBar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:product_catalog/Widgets/EditProfileModal.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/src/material/bottom_sheet.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        context: context,
        title: "username",
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            badges.Badge(
              badgeContent: Icon(
                Icons.edit,
                size: 16,
                color: Colors.white,
              ),
              onTap: () {
                _showEditProfileModal(context);
              },
              position: badges.BadgePosition.topEnd(top: 75, end: 5),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Color(0xff46a096),
              ),
              child: CircleAvatar(
                // backgroundImage: NetworkImage(imageUrl),
                radius: 50,
              ),
            ),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150,
              child: Divider(
                color: Color(0xff46a096),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.teal,
                ),
                title: Text(
                  '+977 9611914934',
                  style: TextStyle(fontSize: 20, color: Colors.teal.shade900),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Color(0xff46a096),
                ),
                title: Text(
                  'test@gmail.com',
                  style: TextStyle(fontSize: 20, color: Colors.teal.shade900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditProfileModal();
      },
    );
  }
}
