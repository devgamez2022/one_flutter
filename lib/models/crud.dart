import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

/*
*Método para consultar toda la información de la colección tb_students 
*/

Future<List> getAlumno() async {
  List students = [];
  CollectionReference collectionReference = db.collection('tb_students');
  QuerySnapshot querySnapshot = await collectionReference.get();
  
  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    final estudiante = {
          "uid": doc.id,
          "first_name": data["first_name"],
          "seconds_name": data["seconds_name"],
    };

    students.add(estudiante);
  }
  
  //await Future.delayed(const Duration(seconds: 2));
  return students;
}


Future<List> getStudiantes1() async {
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


void getDataStudents() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("tb_students");
    QuerySnapshot mensajes = await collectionReference.get();
    if(mensajes.docs.length != 0){
    for (var doc in mensajes.docs){
    print(doc.data());
    //chatsx.add(doc.data());
    }
    }
}



//Método para agregar documentos de alumnos.
Future<void> addAlumno(String nombres, String apellidos) async {
  await db.collection('tb_students').add({"first_name" : nombres, "seconds_name" : apellidos});
}



//Método para actualizar documentos de estudiantes.
Future<void> editAlumno(String uid, String nombres, String apellidos) async {
  await db.collection('tb_students').doc(uid).set({"first_name" : nombres, "seconds_name" : apellidos});
}


  //Método para eliminar documentos de estudiantes.
  Future<void> deleteAlumno(String uid) async{
  await db.collection('tb_students').doc(uid).delete();
  }