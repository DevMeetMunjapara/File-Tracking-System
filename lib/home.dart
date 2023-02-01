import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/main.dart';
import 'package:fts/page/fileStatus.dart';
import 'package:fts/splash/splashServices.dart';

Color PrimaryColor = Color.fromARGB(255, 84, 22, 208);

class Home extends StatelessWidget {
  Home({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> TrackingFrom = GlobalKey<FormState>();
  TextEditingController trakingId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FTS"),
        centerTitle: true,
        backgroundColor: PrimaryColor,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        )),
        leading: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.person));
            })),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 40, bottom: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: PrimaryColor,
                  ),
                  child: Column(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 49,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.green,
                          backgroundImage: AssetImage("img/home/man.png"),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "+91 9409497905",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                    child: ListTile(
                  leading: Icon(
                    Icons.info,
                  ),
                  title: Text("About US"),
                )),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1.5)),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Form(
                        key: TrackingFrom,
                        child: TextFormField(
                          controller: trakingId,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Enter Taracking ID",
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 84, 22, 208))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 84, 22, 208))),
                            prefixIcon: Icon(
                              Icons.location_pin,
                              color: Color.fromARGB(255, 84, 22, 208),
                            ),
                            filled: true,
                          ),
                          validator: (val) {
                            if (val == "") {
                              return "Enter Traking ID";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FullButton(
                          title: "Track File",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FileStatus(trckingId: trakingId.text)));
                          })
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
