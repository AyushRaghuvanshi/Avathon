import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference cr= FirebaseFirestore.instance.collection('Users');

Future<void> adduser(String? uid ,String name){
  final user =  {
  'name':name,
};
return FirebaseFirestore.instance.collection('Users').doc(uid).set(user );
}
