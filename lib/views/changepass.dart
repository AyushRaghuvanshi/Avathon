import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/views/Popup.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({ Key? key }) : super(key: key);

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
      late TextEditingController _email ;
  
  @override
  void initState() {
    _email=TextEditingController();
   
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
   
    super.dispose();
  }
  


  @override
  Widget build(BuildContext context) {
    const double width=350;
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
                            child: Text("Change Password",
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
                        const Text("Email ID:",style: TextStyle(color: Colors.green)),
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
                            
                                   
        
       Row(
         mainAxisAlignment: MainAxisAlignment.end,
         children: [
           Padding(
             padding: const EdgeInsets.only(right: 25,bottom: 30),
             child: TextButton(child: const Text("Send Reset Password Link"),
                style:TextButton.styleFrom(
                              primary: Colors.green,
                              backgroundColor: Colors.white,
                              onSurface: Colors.grey),
                onPressed: () async {
                  final email=_email.text;
                  if(email==''){
                                await showErrorPopup(context, 'Please enter you Email ID');
                                return;
                              }
                  try{
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                } on FirebaseAuthException catch(e){
                  
                  if(e.code=='invalid-email'){
                    await showErrorPopup(context, 'Enter a valid Email ID.');
                    return;
                  }
                  else if(e.code=='user-not-found'){
                    await showErrorPopup(context, 'No Record of this user found');
                  }
                  
                }

                },
                
      ),
           ),
         ],
       ),
                            
                           
                          ],
                        ),
                    ),
                  
                  ),
                ),
       
    );
  }
}