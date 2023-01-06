import 'package:flutter/material.dart';
import 'package:hotel_app/model/hotel_list.dart';
import 'package:hotel_app/service/base_client.dart';
import 'package:hotel_app/service/remote_service.dart';
import './loginScreen.dart';
import 'dart:async';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);
  static const String routeName = '/ClientScreen';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: routeName,
      home: ClientHomePage(),
    );
  }
}

class ClientHomePage extends StatelessWidget {
  ClientHomePage({Key? key}) : super(key: key);

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
            title: const Text('Hotel App User Screen'),
          ),
          body: const TabBarView(
            children: [homeScreen(), historyScreen(), profileScreen()],
          ),
        ));
  }
}

// HOME Screen
class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreen();
}

class _homeScreen extends State<homeScreen> {
  List<HotelList>? allData;
  List<HotelList>? hotels;
  var isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    allData = await RemotesService().getRoomList();
    hotels = allData;
    if (hotels != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  void search(String inputSearch) {
    List<HotelList>? querry = [];
    if (inputSearch.isEmpty) {
      querry = hotels;
    } else {
      for (var i = 0; i < hotels!.length; i++) {
        if (hotels![i]
                .hotelName
                .toLowerCase()
                .contains(inputSearch.toLowerCase()) |
            hotels![i]
                .hotelAddress
                .toLowerCase()
                .contains(inputSearch.toLowerCase())) ;
        {
          querry.add(hotels![i]);
        }
      }
    }

    setState(() {
      hotels = querry;
    });
  }

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
                    onChanged: (value) => search(value),
                    decoration: const InputDecoration(
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
          for (int i = 0; i < hotels!.length; i++)
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
                            Text(hotels![i].hotelName),
                            Text(hotels![i].hotelAddress),
                            ElevatedButton(
                                onPressed: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => roomListScreen(
                                        allRooms: hotels![i].rooms),
                                  ));
                                }),
                                child: Text("Detail")),
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

class roomListScreen extends StatefulWidget {
  final List<Room>? allRooms;

  const roomListScreen({Key? key, this.allRooms}) : super(key: key);
  @override
  State<roomListScreen> createState() => _roomListScreen();
}

class _roomListScreen extends State<roomListScreen> {
  List<Room>? rooms = [];
  @override
  void initState() {
    rooms = widget.allRooms;
    super.initState();
  }

  void search(String inputSearch) {
    List<Room>? querry = [];
    if (inputSearch.isEmpty) {
      querry = widget.allRooms;
    } else {
      for (var i = 0; i < widget.allRooms!.length; i++) {
        if (widget.allRooms![i].roomId
                .toLowerCase()
                .contains(inputSearch.toLowerCase()) |
            widget.allRooms![i].price
                .toLowerCase()
                .contains(inputSearch.toLowerCase())) ;
        {
          querry.add(widget.allRooms![i]);
        }
      }
    }

    setState(() {
      rooms = querry;
    });
  }

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
                    decoration: const InputDecoration(
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
          for (int i = 0; i < rooms!.length; i++)
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
                            Text(rooms![i].roomId),
                            Text(rooms![i].price),
                            ElevatedButton(
                                onPressed: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => bookRoomScreen(
                                      bookRoom: rooms![i],
                                    ),
                                  ));
                                }),
                                child: Text("Book")),
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

class bookRoomScreen extends StatefulWidget {
  final Room bookRoom;

  const bookRoomScreen({Key? key, required this.bookRoom}) : super(key: key);
  @override
  State<bookRoomScreen> createState() => _bookRoomScreen();
}

class _bookRoomScreen extends State<bookRoomScreen> {
  // List<bool> temp1 = [false, false, false, false, false];

  bool temp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.bookRoom.roomId),
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
                child:
                    Text("Price: " + widget.bookRoom.price + r" $ Per Night"),
              ),
              Container(
                child: Text("Bed number: " + widget.bookRoom.bedNums),
              ),
              for (int i = 0; i < widget.bookRoom.furnitures.length; i++)
                Container(child: Text(widget.bookRoom.furnitures[i])),
              // FOR SERVICE
              // CheckboxListTile(
              //   title: Text('Service'),
              //   value: temp1.elementAt(i),
              //   onChanged: ((bool? value) {
              //     setState(() {
              //       temp1[i] = value!;
              //     });
              //   }),
              // ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Book'),
                ),
              ),
            ])),
      ),
    );
  }
}

//PROFILE Screen
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const updateProfileScreen())),
                  child: const Text("Edit Profile")),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
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

//HISTORY Screen
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
