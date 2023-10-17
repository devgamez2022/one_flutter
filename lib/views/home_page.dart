import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_flutter/models/crud.dart';
import 'package:quickalert/quickalert.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Null datos;

  void _alertClose(){
    QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    text: 'Do you want to logout',
    confirmBtnText: 'Aceptar',
    cancelBtnText: 'Cancelar',
    barrierDismissible: false,
    cancelBtnTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    confirmBtnColor: Colors.blue,
    onConfirmBtnTap: () {
      FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, "/login");
    },
    onCancelBtnTap: () {
      Navigator.of(context).pop();
    },
    );
  }

  void _alertSuccess(){
      QuickAlert.show(
      context: context,
      text: '¿Realmente desea cerrar su sesión?',
      type: QuickAlertType.confirm,
      onConfirmBtnTap: (){
        FirebaseAuth.instance.signOut();
        Navigator.pushNamed(context, "/login");
      }
    ); // That's it to display an alert, use other properties to customize.
  }

  void _dataFireBase(){
        db.collection("tb_students").where("first_name", isEqualTo: "Ana").get().then(
        (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  void _dataFireBase1(){
    setState(() {
              //db = FirebaseFirestore.instance;
        db.collection("tb_students").get().then(
        (querySnapshot) {
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            //datass = docSnapshot.data();
            print('${docSnapshot.id} => ${docSnapshot.data()}');
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    });

  }

  
  /*appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => print('Icono Uno'),
              );
            },
          ), 
          title: const Text('CRUD'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => print('Edit'),
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () => print('Save'),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => print('Delete'),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => print('Close'),
            ),
          ],
        )
  */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //leading: const Icon(Icons.close),
        leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    //Has presionado...
                    print('Has presionado icono menu');
                  },
                );
              },
            ),
        actions: [
          IconButton(
            //onPressed: () => print('Has presionado cerrar sesion'), 
            onPressed: (){
              /* FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login"); */
              _alertClose();
            },
            icon: const Icon(Icons.close)
            )
        ],
      ),
      body: FutureBuilder(
        future: getAlumno(), 
        builder: ((context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  //Este metodo se ejecuta despues de haber desaparecido el elemento de la pantalla
                  onDismissed: (direction) async{
                    //Aca va el llamado del metodo que elimina el documento o registro
                    //de la base de datos de firebase.
                    await deleteAlumno(snapshot.data?[index]['uid']);
                    //Eliminando el dato de la memoria del snapshot
                    snapshot.data?.removeAt(index);
                    setState(() {
                      
                    });
                  },
                  //Este metodo se ejectua 
                  confirmDismiss: (direction) async{
                    //print('Confirmacion de Dismissible');
                    bool result = false;
                    result = await showDialog(
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          title: Text("¿Realmente desea eliminar a ${snapshot.data?[index]['first_name']} ${snapshot.data?[index]['seconds_name']}?"),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context, false);
                              }, 
                              child: const Text("Cancelar", style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber
                              ),)),
                              TextButton(
                              onPressed: (){
                                Navigator.pop(context, true);
                              }, 
                              child: const Text("Aceptar"))
                          ],
                        );
                      });
                    return result;
                  },
                  background: Container( 
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  //key: UniqueKey(),
                  key: Key(snapshot.data?[index]['uid']),
                  direction: DismissDirection.endToStart,
                  child: Card(
                        elevation: 10,
                        clipBehavior: Clip.hardEdge,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            //color: Theme.of(context).colorScheme.outline,
                             color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: InkWell(
                          //splashColor: Colors.blue.withAlpha(30),
                          splashColor: Colors.grey,
                          onTap: () async{
                            //debugPrint(snapshot.data?[index]['first_name'] + " " + snapshot.data?[index]['seconds_name']);
                            await Navigator.pushNamed(context, "/edit", arguments: {
                              'uid' : snapshot.data?[index]['uid'],
                              'nombres' : snapshot.data?[index]['first_name'],
                              'apellidos' : snapshot.data?[index]['seconds_name']
                            });
                            setState(() {
                              
                            });
                          },
                          child: SizedBox(
                            width: 300,
                            height: 100,
                            child: Center(
                              child: Text(
                                snapshot.data?[index]['first_name'] + " " + snapshot.data?[index]['seconds_name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                );
              }),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
              );
          } 
        })
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        await Navigator.pushNamed(context, "/add");
        setState(() {
          
        });
        //print('Termino la espera');
      },
      child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getDataStudents();
  }


}