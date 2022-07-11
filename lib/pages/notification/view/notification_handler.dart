import 'package:flutter/material.dart';

class NotificationHandler extends StatefulWidget {
  //const NotificationHandler({Key? key}) : super(key: key);
  String? notificationId;
  String? notificationTitle;
  String? notificationBody;

  NotificationHandler(
      this.notificationId, this.notificationTitle, this.notificationBody);

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
          child: Column(
            children: [
              Text(
                "${widget.notificationBody}",
                style: TextStyle(),
                textAlign: TextAlign.justify,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "ID - ${widget.notificationId}",
                  style: TextStyle(),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
