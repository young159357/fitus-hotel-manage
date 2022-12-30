// ignore: file_names
import 'package:flutter/material.dart';
import './Client.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 40,
              ),
            ),
            const Divider(
              height: 60,
              color: Colors.grey,
            ),
            const Text(
              'Name',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              'John Doe',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30,),
            const Text(
              'Actor',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              'Admin',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30,),
            const Text(
              'Email',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              'nls@fitus.edu.vn',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30,),
            const Text(
              'Phone',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              '0123456789',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ), 
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const updateProfileScreen())),
                child: const Text("Edit Profile")),
            ),
          ],
        ),
      )
    );
  }
}