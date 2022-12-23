// ignore: file_names
// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import './Staff.dart';
import './User.dart';
import './UserInfo.dart';
class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const String routeName = 'Hotel App Admin Screen';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: routeName,
      home: AdminPage(),
    );  
  }
}

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel App Admin Screen'),
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('Admin Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Hotel App Admin Screen'),
            ),
            ListTile(
              leading: const Icon(Icons.apps_outlined),
              title: const Text('Staff Screen'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StaffPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.apps_outlined),
              title: const Text('User Screen'),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserInfo()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserScreen()),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}