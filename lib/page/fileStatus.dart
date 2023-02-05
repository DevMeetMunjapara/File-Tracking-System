import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fts/customwidget/fileStatusIcon.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/customwidget/infoStatus.dart';
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Current File Status / Information",
                    style: TextStyle(
                        color: Color.fromARGB(255, 60, 102, 219),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.5,
                          ),
                        ]),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showFileData(
                              "Tracking Id", snapshot.data!.reference.id),
                          showFileData(
                            "File Status",
                            snapshot.data!.reference.id,
                          ),
                        ],
                      ),
                    ),
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

  Widget showFileData(String title, String fileData, {IconData}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 17, color: Colors.blue),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                fileData,
                style: TextStyle(fontSize: 15),
              ),
              FileStatusIcon(fileStatus: IconData)
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          )
        ],
      ),
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
                InfoStatus(),
                getFileData(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
