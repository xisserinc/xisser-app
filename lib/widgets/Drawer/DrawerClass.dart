import 'package:fashionify/pages/profile/ContactClass.dart';
import 'package:fashionify/pages/profile/Terms&Conditions.dart';
import 'package:fashionify/widgets/ui_elements/logout_list_tile.dart';
import 'package:flutter/material.dart';

class DrawerClass extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.teal),
          accountName: Text(
            'Richard James',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          accountEmail: Text(
            'richardjb631@gmail.com',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          currentAccountPicture: CircleAvatar(
            child: Text('R'),
            backgroundColor: Colors.green,
          ),
        ),
        ListTile(
          trailing: Icon(Icons.arrow_forward),
          onTap: () {},
          title: Text('About Us'),
        ),
        ListTile(
          trailing: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        ListTile(
          trailing: Icon(Icons.phone),
          title: Text('Contacts & Support'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactClass(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('terms & Conditions'),
          trailing: Icon(Icons.add_alert),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TermsClass(),
              ),
            );
          },
        ),
        LogoutListTile()
      ],
    );
  }
}
