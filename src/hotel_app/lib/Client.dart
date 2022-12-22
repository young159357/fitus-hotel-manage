// ignore: file_names
import 'package:flutter/material.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);
  static const String routeName = '/ClientScreen';
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
                Tab(text: "Home"),
                Tab(text: "History"),
                Tab(text: "Profile"),
              ],
            ),
            title: const Text('Flutter Tabs Example'),
          ),
          body: const TabBarView(
            children: [homeScreen(), historyScreen(), profileScreen()],
          ),
        ));
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
                                BorderRadius.all(Radius.circular(25.0)))),
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
                            Text("detail"),
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 60,
            ),
            SizedBox(
              height: 20,
            ),
            Text("name"),
            Text("example@gmail.com"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const updateProfileScreen())),
                child: Text("Edit Profile")),
            SizedBox(
              height: 300,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Logout"))
          ],
        ),
      ),
    ));
  }
}

class historyScreen extends StatefulWidget {
  const historyScreen({Key? key}) : super(key: key);

  @override
  State<historyScreen> createState() => _historyScreen();
}

class _historyScreen extends State<historyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("No room history")),
    );
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
                ],
              ))
            ])),
      ),
    );
  }
}

class bookRoomScreen extends StatefulWidget {
  const bookRoomScreen({Key? key}) : super(key: key);

  @override
  State<bookRoomScreen> createState() => _bookRoomScreen();
}

class _bookRoomScreen extends State<bookRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("hello world")),
    );
  }
}
