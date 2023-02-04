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
          return Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 15,
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Traking ID : " + trckingId,
                                    textScaleFactor: 1.3,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  FileStatusIcon(fileStatus: data["fileStatus"])
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "File Status",
                                textScaleFactor: 1.2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Status :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["fileStatus"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Resion :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["lastUpdateReason"],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Update Date :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["lastUpdateDate"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Update Time :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["lastUpdateTime"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Current Department :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["currentDepartment"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Sub Department :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["currentSubDepartment"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Officer Name :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["officerName"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "File Submite Resion :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["submitReason"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
//File Details
                              const Text(
                                "File Details",
                                textScaleFactor: 1.2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "File Name :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["fileName"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "submit Reason :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["submitReason"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "File colour :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["colour"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Total Page :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["totalPages"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Submit Department :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["submitDepartment"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Submit Sub Department :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["submitSubDepartment"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Submit Date :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["submitDate"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
//File Details
                              const Text(
                                "File Owner Details",
                                textScaleFactor: 1.2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Owner Name :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["name"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Owner Mobile Number :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["mobileNumber"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Owner Email Id :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["email"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
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
