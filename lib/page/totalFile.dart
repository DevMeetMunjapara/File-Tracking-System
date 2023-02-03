import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fts/customwidget/fileStatusIcon.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/page/fileStatus.dart';
import 'package:fts/splash/splashServices.dart';

class TotalFile extends StatelessWidget {
  late int allFileCount;
  TotalFile({
    super.key,
    required this.allFileCount,
  });

  int count = 0;

  final db = FirebaseFirestore.instance
      .collection("allUser")
      .doc(loginMobileNumber)
      .collection("allFile")
      .snapshots();

  Widget allFile() {
    return Text(allFileCount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Files"),
          backgroundColor: PrimaryColor,
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 198, 165, 254),
                            border: Border.all(
                                color: Color.fromARGB(255, 57, 2, 151)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Total File ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            allFile(),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: db,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Some Error",
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }

                        if (snapshot.hasData) {}
//builder
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                  elevation: 15,
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data!.docs[index]
                                                  .reference.id
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            FileStatusIcon(
                                                fileStatus: snapshot.data!
                                                    .docs[index]["fileStatus"])
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "File Name :- ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshot
                                                  .data!.docs[index]["fileName"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "File Submit Date :- ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshot.data!
                                                  .docs[index]["submitDate"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: PrimaryColor),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FileStatus(
                                                            trckingId: snapshot
                                                                .data!
                                                                .docs[index]
                                                                .reference
                                                                .id
                                                                .toString(),
                                                          )));
                                            },
                                            child: Text(
                                              "Trak File",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                  )),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
