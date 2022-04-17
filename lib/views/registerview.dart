
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:project/database/sevices.dart';

import 'package:project/views/popup.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({ Key? key }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _email ;
  late TextEditingController _password;
  late TextEditingController _name;
  @override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    _name=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    const width=325.0;
    return Scaffold(
      body: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: 400,
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            const SizedBox(   
                        height: 200,
                        child:Padding(
                            padding: EdgeInsets.fromLTRB(30,100,0,0),
                            child: Text("Create Account",
                            style: TextStyle(fontSize: 35,
                            color: Colors.green,
                              fontWeight: FontWeight.bold,
                            )),
                          ),
                        ),
                            Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email ID:",style: TextStyle(color: Colors.green),),
                        SizedBox(
                      width: width,
                      child: TextField(controller: _email,
                                    
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    decoration: const InputDecoration(hintText: "Enter you email here"),
                      ),
                    )
                      ],
                    ),
                  ),
                            ),
                            
                            Padding(
                             padding: const EdgeInsets.only(bottom: 30),
                             child: Center(
                   
                   child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Name:",style: TextStyle(color: Colors.green),),
                          SizedBox(
                            width: width,
                            child: TextField(controller: _name,
                                          obscureText: false,
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          decoration: const InputDecoration(hintText: "Enter you name here"),      
                            ),
                          ),
                        ],
                      ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 30),
                             child: Center(
                   
                   child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Password:",style: TextStyle(color: Colors.green),),
                          SizedBox(
                            width: width,
                            child: TextField(controller: _password,
                                          obscureText: true,
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          decoration: const InputDecoration(hintText: "Enter you password here"),      
                            ),
                          ),
                        ],
                      ),
                             ),
                           ),
                            
                            
                            Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Container(
                      width: width,
                      decoration: const BoxDecoration(color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.green,
                              onSurface: Colors.grey,
                    ),
                            
                            onPressed: ()async{
                              final email=_email.text;
                              final password=_password.text;
                              final name= _name.text;
                              if(email==''&&password==''){
                                await showErrorPopup(context, 'Please enter your Email ID and Password');
                                return;
                              }else if(email==''){
                                await showErrorPopup(context, 'Please enter you Email ID');
                                return;
                              }else if(password ==''){
                                await showErrorPopup(context, 'Please enter you Password');
                                return;}
                                else if(name==""){
                                  await showErrorPopup(context, 'Please enter your name');
                                }
                              try{
                              
                              
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                              await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                              final user= FirebaseAuth.instance.currentUser;
                              final uid =user?.uid;
                              await adduser(uid, name);
                              await user?.sendEmailVerification();
                              } on FirebaseAuthException catch(e){
                                
                                switch(e.code){
                                  case 'email-already-in-use':
                                    await showErrorPopup(context, 'You have already registered. Try logging in');
                                    return;
                                  case 'invalid-email':
                                    await showErrorPopup(context, 'Enter a valid Email ID ');
                                    return;
                                  case 'weak-password':
                                    await showErrorPopup(context, 'Password should be at least contain 5 character.');
                                    return;
                                  case 'unknown':
                                  await showErrorPopup(context,'Opps, looks like an Error occured. Please contant the Dev');
                                  return;
                               


                                }

                              }
                              Navigator.of(context).pushNamedAndRemoveUntil('/email_verification/', (route) => false);
                              // await showPopup(context, 'Email Verification link has been send to your email id. Please Verify','Email Verification');
                              
                            }, 
                            child: const Text("Register",style:TextStyle(color: Colors.white),)),
                    ),
                  ),
                            ),
                            
                            
                            const Center(child: Text("Already have an account?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black45),)),                          
                            Center(child: TextButton(onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
                            }, style:TextButton.styleFrom(
                              primary: Colors.green,
                
                              backgroundColor: Colors.white,
                              onSurface: Colors.grey)
                              ,child: const Text("Login",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green),),))
                          ],
                        ),
                    ),
                  ),
                ),
    );
  }
}


