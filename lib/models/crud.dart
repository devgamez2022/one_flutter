import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getStudiantes() async {
  List students = [];
  CollectionReference collectionReference = db.collection('tb_students');
  QuerySnapshot querySnapshot = await collectionReference.get();
  /*
  for (var documento in querySnapshot.docs) {
    students.add(documento.data());
  }
  */
  querySnapshot.docs.forEach((documento) {
    students.add(documento.data());
  });

  print('$students');

  return students;
}