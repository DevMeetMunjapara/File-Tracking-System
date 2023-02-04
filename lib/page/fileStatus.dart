import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fts/customwidget/fileStatusIcon.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/splash/splashServices.dart';

class FileStatus extends StatelessWidget {
  var trckingId;

  FileStatus({
    super.key,
    required this.trckingId,
  });

  var fileData = FirebaseFirestore.instance
      .collection("allUser")
      .doc(loginMobileNumber)
      .collection("allFile");

  Widget getFileData() {
    return FutureBuilder(
      future: fileData.doc(trckingId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(
                child: Text(
              "File Data Not Exsit",
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.red),
            )),
          );
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Padding(
            padding: EdgeInsets.only(top: 50),
            child: Center(
                child: Column(
              children: const [
                Image(
                  image: AssetImage("img/home/notFound.png"),
                  height: 90,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "File Not Found",
                  textScaleFactor: 1.7,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                )
              ],
            )),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print(data);
          return Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tracking ID :-  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          snapshot.data!.id,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        FileStatusIcon(
                          fileStatus: data["fileStatus"],
                          setSize: 30.toDouble(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Current File Status ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: Text("File Status"),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "File Reject ",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "In Procces ",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.work_history,
                            color: Color.fromARGB(255, 234, 187, 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "File Approve ",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.verified,
                            color: Color.fromARGB(255, 15, 161, 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                getFileData(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
