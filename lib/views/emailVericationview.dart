

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({ Key? key }) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Center(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(Icons.warning_amber_rounded,
                      color: Colors.red,
                      size: 75
                    ),
                  )
                  ,
                  const Padding(
                    padding:  EdgeInsets.all(10),
                    child:  Text("Opps, Looks like your Email ID is not verified.",
                    style: TextStyle(fontSize: 17,fontWeight: FontWeight.w900),
                 ),
                  ),
                 const Padding(
                   padding:  EdgeInsets.all(5),
                   child:  Text("Verify your Email Id and try logging in again",
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                   ),
                 ),
                   Padding(
                    padding:  const EdgeInsets.all(0),
                    child: TextButton(onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                    }, 
                    style:TextButton.styleFrom(
                                    primary: Colors.green,
                                    backgroundColor: Colors.white,
                                    onSurface: Colors.grey),
                    child: const Text("Send verification Link")),
                  )
                  ,TextButton(onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
                  },
                  style:TextButton.styleFrom(
                                  primary: Colors.green,
                    
                                  backgroundColor: Colors.white,
                                  onSurface: Colors.grey)
                  ,child: const Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}