import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/views/changepass.dart';
import 'package:project/views/loginview.dart';

import 'package:project/views/registerview.dart';
import 'views/emailVericationview.dart';
import 'views/mainpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const HomePage(),
      routes: {
        '/login/':(context) => const LoginView(),
        '/register/':(context) => const RegisterView(),
        '/mainpage/':(context) => const MainPage(),
        '/email_verification/':((context) => const EmailVerification()),
        '/changepass/':((context) => const Changepassword()),
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:  Firebase.initializeApp(),
        builder: ((context, snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.done:
            final user =FirebaseAuth.instance.currentUser;
            if(user==null){
              return const LoginView();
            }
            else{
            if( user.emailVerified){
              return const MainPage();
            }
            else {
              return const EmailVerification();
            }
          }
          default:
              return const CircularProgressIndicator();
        }
      } ))
    );
  }
}
