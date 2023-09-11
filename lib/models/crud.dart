import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

/**Metodo para consultar toda la informacion de la coleccion tb_students */

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
  //print('$students');
  await Future.delayed(const Duration(seconds: 2));
  return students;
}

Future<void> addAlumno(String nombres, String apellidos) async {
  await db.collection('tb_students').add({"first_name" : nombres, "seconds_name" : apellidos});
}