import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fts/customwidget/drawer.dart';
import 'package:fts/customwidget/fileStatusIcon.dart';
import 'package:fts/page/fileStatus.dart';
import 'package:fts/splash/splashServices.dart';

class TotalFile extends StatelessWidget {
  var totalFile = 0;
  TotalFile({
    super.key,
    required int allFileCount,
  });

  final db = FirebaseFirestore.instance
      .collection("allUser")
      .doc(loginMobileNumber)
      .collection("allFile")
      .snapshots();

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
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 30),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: const [
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
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 30),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: const [
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

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data!.docs[index].id);
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
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            FileStatusIcon(
                                                fileStatus: snapshot.data!
                                                    .docs[index]["fileStatus"])
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "File Name :- ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshot
                                                  .data!.docs[index]["fileName"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "File Submit Date :- ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshot.data!
                                                  .docs[index]["submitDate"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
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
                                            child: const Text(
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
