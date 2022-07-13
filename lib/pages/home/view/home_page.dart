import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:user_app/pages/form/view/add_user_form_page.dart';
import 'package:user_app/pages/notification/view/notification_handler.dart';
import 'package:user_app/pages/notification/view/send_notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseMessaging messaging;

  final loc.Location _location = loc.Location();

  double? currentLocationLatitude;
  double? currentLocationLongitude;

  bool locationLoaded = true;

  var userMap = {};
  var sortedMap = {};

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  sortByLocationNearMe() async {
    final loc.LocationData _locationResult = await _location.getLocation();
    currentLocationLatitude = _locationResult.latitude;
    currentLocationLongitude = _locationResult.longitude;
    double distanceInMeters;
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((documentSnapshot) {
                distanceInMeters = Geolocator.distanceBetween(
                    currentLocationLatitude!,
                    currentLocationLongitude!,
                    documentSnapshot['locationLatitude'],
                    documentSnapshot['locationLongitude']);
                userMap[distanceInMeters] = [
                  documentSnapshot['name'],
                  documentSnapshot['phoneNumber'],
                  documentSnapshot['sex'],
                  documentSnapshot['location']
                ];
              })
            });
    sortedMap = Map.fromEntries(
        userMap.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    print(sortedMap);
  }

  @override
  void initState() {
    super.initState();

    sortByLocationNearMe().then((value) => {
          setState(() {
            locationLoaded = false;
          })
        });

    messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print("THE TOKEN");
      print(value);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("Message recieved");
      print(event.notification!.title);
      print(event.notification!.body);
      print(event.data.keys.elementAt(0));
      print(event.data.values.elementAt(0));
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${event.notification!.title}"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("READ"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotificationHandler(
                            event.data.values.elementAt(0),
                            event.notification!.title,
                            event.notification!.body)));
                  },
                )
              ],
            );
          });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotificationHandler(
              message.data.values.elementAt(0),
              message.notification!.title,
              message.notification!.body)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddUserForm()),
            );
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notification_add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SendNotification()),
                );
              },
            )
          ],
        ),
        body: locationLoaded
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                primary: false,
                children: sortedMap.entries
                    .map((entry) => Card(
                          child: ListTile(
                            title: Text("Name: ${entry.value[0]}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone Number: ${entry.value[1]}"),
                                Text("Gender: ${entry.value[2]}"),
                                Text("Location: ${entry.value[3]}"),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        ))
                    .toList(),
              ));
  }
}
