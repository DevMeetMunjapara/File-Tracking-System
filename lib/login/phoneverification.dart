import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fts/customwidget/fullbutton.dart';

class phoneverification extends StatefulWidget {
  const phoneverification({super.key});

  static String verify = "";

  @override
  State<phoneverification> createState() => _phoneverificationState();
}

class _phoneverificationState extends State<phoneverification> {
  final GlobalKey<FormState> _mobileKey = GlobalKey<FormState>();
  TextEditingController _mobileNumber = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileNumber.addListener(
      () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              const Image(
                image: AssetImage("img/login/mobileNumber.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Phone Verfication",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone number before getting started!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _mobileKey,
                child: TextFormField(
                  onTap: () {
                    _mobileNumber.text = "+91".toString();
                  },
                  controller: _mobileNumber,
                  keyboardType: TextInputType.number,
                  cursorColor: PrimaryColor,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: PrimaryColor),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: PrimaryColor),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: PrimaryColor,
                    ),
                    hintText: "Enter Mobile Number",
                    hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    filled: true,
                    fillColor: Color.fromARGB(255, 231, 231, 231),
                  ),
                  validator: (phno) {
                    if (phno!.isEmpty || phno == null) {
                      return "Enter Mobile Number";
                    }
                    if (phno.length < 10) {
                      return 'Mobile Number Must Be 10 Digits!';
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              FullButton(
                title: "Send OTP",
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${_mobileNumber.text + phone}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      phoneverification.verify = verificationId;
                      Navigator.pushNamed(context, 'verify');
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
