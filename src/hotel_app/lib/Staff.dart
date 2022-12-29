// ignore: file_names
import 'package:flutter/material.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({Key? key}) : super(key: key);
  static const String routeName = '/StaffScreen';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: routeName,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Manage"),
                Tab(text: "Schedule"),
                Tab(text: "Profile"),
              ],
            ),
            title: const Text('Staff'),
          ),
          body: const TabBarView(
            children: [homeScreen(), scheduleScreen(), profileScreen()],
          ),
        ));
  }
}

class scheduleScreen extends StatefulWidget {
  const scheduleScreen({Key? key}) : super(key: key);

  @override
  State<scheduleScreen> createState() => _scheduleScreen();
}

class _scheduleScreen extends State<scheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('hello world')));
  }
}

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreen();
}

class _homeScreen extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)))),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < 5; i++)
            Container(
              height: 200,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Image"),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("description"),
                            ElevatedButton(
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const detailScreen())),
                                child: Text("Edit")),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreen();
}

class _profileScreen extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 50,
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
            const SizedBox(
              height: 30,
            ),
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
            const SizedBox(
              height: 30,
            ),
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
            const SizedBox(
              height: 30,
            ),
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
            Center(
              child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const updateProfileScreen())),
                  child: const Text("Edit Profile")),
            ),
            const SizedBox(
              height: 130,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const updateProfileScreen()),
                    );
                  },
                  child: const Text("Logout")),
            ),
          ],
        ),
      ),
    ));
  }
}

class updateProfileScreen extends StatefulWidget {
  const updateProfileScreen({Key? key}) : super(key: key);
  @override
  State<updateProfileScreen> createState() => _updateProfileScreen();
}

class _updateProfileScreen extends State<updateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Update Profile"),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              CircleAvatar(
                radius: 60,
              ),
              Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("NAME"),
                        prefixIcon: Icon(Icons.account_circle_outlined)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("EMAIL"),
                        prefixIcon: Icon(Icons.mail_outline_rounded)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("PHONE"),
                        prefixIcon: Icon(Icons.phone_outlined)),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Save")),
                ],
              ))
            ])),
      ),
    );
  }
}

class detailScreen extends StatefulWidget {
  const detailScreen({Key? key}) : super(key: key);
  @override
  State<detailScreen> createState() => _detailScreen();
}

class _detailScreen extends State<detailScreen> {
  List<bool> temp1 = [false, false, false, false, false];
  List<String> temp2 = ["", "", "", "", "", "", ""];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Room"),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              Container(
                height: 150.0,
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: new Center(
                      child: new Text(
                        "Room image",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
              Container(
                child: Text('description'),
              ),
              for (int i = 0; i < 5; i++)
                TextField(
                  decoration: InputDecoration(
                    label: Text('description'),
                  ),
                  maxLines: null,
                  textAlign: TextAlign.left,
                  onChanged: ((value) {
                    temp2[i] = value;
                  }),
                ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Update'),
                ),
              ),
            ])),
      ),
    );
  }
}
