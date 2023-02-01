import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/customwidget/notificationService.dart';
import 'package:fts/splash/splashServices.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationWidget.init();
    demo();
  }

  void demo() {
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationSterem =
        FirebaseFirestore.instance
            .collection("allUser")
            .doc(loginMobileNumber)
            .collection("allFile")
            .snapshots();

    StreamSubscription<QuerySnapshot<Map<String, dynamic>>> streamSubscriptio =
        notificationSterem.listen((event) {
      if (event.docs.isEmpty) {
        return;
      }
      print(event.docs.last.id);
      var newFileAdd = event.docs.last.id;
      NotificationWidget.showNotificationOnFirebase(
          title: "New File Add", body: "the New File Name is $newFileAdd");
    });
  }

  // void showNotification(QueryDocumentSnapshot<Map<String, dynamic>> event) {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     '001',
  //     'Local Notifiaction',
  //     channelDescription: "TO send local Notification",
  //     importance: Importance.max,
  //   );
  //   const NotificationDetails details =
  //       NotificationDetails(android: androidNotificationDetails);
  //   flutterLocalNotificationsPlugin.show(
  //       01, event.get("fileName"), event.get("fileStatus"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
        ),
        backgroundColor: PrimaryColor,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NotificationWidget.showNotification(
                title: "Notification", body: "This is Testing Notifiaction");
            ;
          },
          child: Text("Notification"),
        ),
      ),
    );
  }
}
