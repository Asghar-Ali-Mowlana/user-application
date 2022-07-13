import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../home/view/home_page.dart';

class SendNotification extends StatefulWidget {
  const SendNotification({Key? key}) : super(key: key);

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController idController = new TextEditingController();
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController contentController = new TextEditingController();

  double? locationLatitude;
  double? locationLongitude;

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  sendNotification() async {
    final response =
        await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAAqYENZV8:APA91bG5zaNu9mUOMc8glnRi5tPoFMimeHl8kGRvB8P4kOejJzRTTMZ9XAVk1HbWOCLDYYRQvCuzCI5gj00oGRHwdCA5SjtfZlap1J8HkgSsh21yqPxSQNCO4Iux4mAJFzZqiaeW5C5s',
            },
            encoding: Encoding.getByName('utf-8'),
            body: jsonEncode({
              "to": "/topics/all", // topic name
              "notification": {
                "title": titleController.text,
                "body": contentController.text,
                "sound": "default"
              },
              "data": {
                "id": idController.text, //data passed
              }
            }));

    if (response.statusCode == 200) {
      print('TEST OK PUSH CFM');
      return true;
    } else {
      print(' CFM ERROR');
      print(response.body);
      print(response.statusCode);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Notification"),
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
                    controller: idController,
                    decoration: InputDecoration(
                      hintText: "Enter your id",
                      labelText: "ID",
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
                        return "ID cannot be empty";
                      }
                      if (value.length < 3) {
                        return ("Please enter a valid id");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      idController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Enter your title",
                      labelText: "Title",
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
                        return "Title cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      titleController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: contentController,
                    decoration: InputDecoration(
                      hintText: "Enter your content",
                      labelText: "Content",
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
                        return "Content cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) async {
                      contentController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendNotification().then((value) => {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const HomePage()),
                            // )
                          });
                    }
                  },
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
