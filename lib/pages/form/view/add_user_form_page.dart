import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:user_app/pages/home/view/home_page.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController numberController = new TextEditingController();
  final TextEditingController sexController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();

  String? sexValue;
  double? locationLatitude;
  double? locationLongitude;

  final sex = [
    "Male",
    "Female",
  ];

  DropdownMenuItem<String> buildMenuItem(String place) => DropdownMenuItem(
        value: place,
        child: Text(
          place,
          style: const TextStyle(fontSize: 16.0),
        ),
      );

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  var token;

  Future<void> addUser() async {
    List<Location> locations =
        await locationFromAddress(locationController.text);
    locationLatitude = locations.first.latitude;
    locationLongitude = locations.first.longitude;
    
    await messaging.subscribeToTopic('all');

    messaging.getToken().then((value) {
      print("THE TOKEN");
      print(value);
      return FirebaseFirestore.instance
          .collection('users')
          .doc(value)
          .set({
            'name': nameController.text,
            'phoneNumber': numberController.text,
            'sex': sexValue,
            'location': locationController.text,
            "locationLatitude": locationLatitude,
            "locationLongitude": locationLongitude,
            'subscribedTopic': 'all'
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New User"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      labelText: "Name",
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: new TextStyle(color: Colors.black),
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value!.length == 0) {
                        return "Name cannot be empty";
                      }
                      if (value.length < 3) {
                        return ("Please enter a valid name");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      nameController.text = value!;
                    },
                    keyboardType: TextInputType.name,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: numberController,
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      labelText: "Phone Number",
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: new TextStyle(color: Colors.black),
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value!.length == 0) {
                        return "Phone number cannot be empty";
                      }
                      if (value.length != 10) {
                        return ("Please enter a valid phone number");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      numberController.text = value!;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: "Sex",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: 'Sex',
                      labelStyle: TextStyle(color: Colors.black),
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                      ),
                    ),
                    dropdownColor: Colors.white70,
                    style: TextStyle(color: Colors.black),
                    isExpanded: true,
                    value: sexValue,
                    items: sex.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() {
                      this.sexValue = value as String?;
                    }),
                    validator: (value) {
                      if (value == null) {
                        return ("Please select Male or Female");
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: "Enter your location",
                      labelText: "Location",
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: new TextStyle(color: Colors.black),
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value!.length == 0) {
                        return "Location cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) async {
                      locationController.text = value!;
                    },
                    keyboardType: TextInputType.streetAddress,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addUser().then((value) => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            )
                          });
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
