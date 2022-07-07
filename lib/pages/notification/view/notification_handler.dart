import 'package:flutter/material.dart';

class NotificationHandler extends StatefulWidget {
  //const NotificationHandler({Key? key}) : super(key: key);

  String? notificationTitle;
  String? notificationBody;

  NotificationHandler(this.notificationTitle, this.notificationBody);

  @override
  State<NotificationHandler> createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.notificationTitle}"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Text(
            "${widget.notificationBody}",
            style: TextStyle(),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
