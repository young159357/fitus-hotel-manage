// ignore: file_names
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hotel_app/model/user_list.dart';
import 'package:hotel_app/service/remote_service.dart';

import './Staff.dart';
import './UserInfo.dart';
import './loginScreen.dart';
import './Client.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<UserProfile>? users;
  var isloaded = false;
  var check = false;
  int number = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    users = await RemotesService().getUserProfile();
    if (users != null) {
      setState(() {
        isloaded = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel App Admin Screen'),
        automaticallyImplyLeading: true,
      ),
      body: Visibility(
        visible: isloaded,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: ListView(
            children: <Widget>[
              //User List
              const Text(
                'User List',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              for (int i = 0; i < 5; i++)
                Container(
                  child: Card(
                    child: ListTile(
                      title: Text(users![i].name),
                      subtitle: Text(users![i].email),
                      trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: const Icon(Icons.delete),
                          onPressed: () {
                            /*persons.removeWhere((element){
                            return element.id = person.id
                          });
                          setState((){

                          });*/
                          }),
                    ),
                  ),
                ),

              //Staff List
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Staff List',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              for (int i = 0; i < 5; i++)
                Container(
                  child: Card(
                    child: ListTile(
                      title: Text(users![i].name),
                      subtitle: Text(users![i].email),
                      trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: const Icon(Icons.delete),
                          onPressed: () {
                            /*persons.removeWhere((element){
                            return element.id = person.id
                          });
                          setState((){

                          });*/
                          }),
                    ),
                  ),
                ),
            ],
          ),
        ),
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
              title: const Text('User Screen'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientHomePage()),
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
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
