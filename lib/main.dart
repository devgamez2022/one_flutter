import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_flutter/models/crud.dart';
import 'firebase_options.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MyApp());
}

//void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Null datos;
  dynamic datass;

  var _primerNombre="";
  final _segundoNombre="";

  void _dataFireBase(){
        // Create a reference to the cities collection
        //final citiesRef = db.collection("cities");

        // Create a query against the collection.
        //final query = citiesRef.where("state", isEqualTo: "CA");

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: FutureBuilder(
        future: getStudiantes(), 
        builder: ((context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: ((context, index) {
                //datos = snapshot.data?[index]['first_name'];
                return Text(
                  snapshot.data?[index]['first_name'] + " " + snapshot.data?[index]['seconds_name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                    ),
                    
                );
              }),
              );
        })
      ),
    );
  }
}

/*
FutureBuilder(
        future: getStudiantes(), 
        builder: ((context, snapshot) {
            return ListView.builder(
              //itemBuilder: snapshot.data?.length,
              itemCount: snapshot.data?.length,
              itemBuilder: ((context, index) {
                datos = snapshot.data?[index]['first_name'];
                return Text(
                  '$datos'
                );
              }),
              );
        })
      ),
*/

/*
Column(
        children: [
          Center(child: Text('$datass',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
          ElevatedButton(
            onPressed: _dataFireBase1, 
            child: Text('Mostrar dato'))
        ],
      )
*/