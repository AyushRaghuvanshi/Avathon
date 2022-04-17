



import 'package:flutter/material.dart';

Future<bool> showLogoutPop(BuildContext context){
  return showDialog(context: context, 
  builder: (context){
   return  AlertDialog(
     title: const Text("Log out"),
     content: const Text("Are you sure to Log out?"),
    actions:  [
      TextButton(onPressed: () {
        Navigator.of(context).pop(false);
      }, child: const Text("Cancel",style: TextStyle(color: Colors.red),)),
      TextButton(onPressed: () {
        Navigator.of(context).pop(true);
      }, child: const Text("Log out"))
    ],

   );
  }
  ).then((value) => value ?? false);
  
}


Future<bool> showErrorPopup(BuildContext context, String text){
  
  return showDialog(context: context, 
  builder: (context){
   return  AlertDialog(
     title: const Text("Error"),
     content: Text(text),
    actions:  [
      TextButton(onPressed: () {
        Navigator.of(context).pop();
      }, child: const Text("Ok")),
      
    ],

   );
  }
  ).then((value) => value ?? false);
  
}



Future<bool> showPopup(BuildContext context, String text,String title){
  
  return showDialog(context: context, 
  builder: (context){
   return  AlertDialog(
     title:  Text(title),
     content: Text(text),
    actions:  [
      TextButton(onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
      }, child: const Text("Ok")),
      
    ],

   );
  }
  ).then((value) => value ?? false);
  
}


Future<bool> loadingpopup(BuildContext context){
  
  return showDialog(context: context, 
  builder: (context){
   return  CircularProgressIndicator();
  }).then((value) => value ?? false);
  
}

