import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_flutter/views/add_students.dart';
import 'package:one_flutter/views/edit_students.dart';
import 'package:one_flutter/views/home_page.dart';
import 'package:one_flutter/views/login.dart';
import 'package:one_flutter/views/login_page.dart';
import 'package:one_flutter/views/sign_up_auth.dart';
import 'package:one_flutter/views/signup.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: "/login",
      routes: {
        "/": (context) => const Home(),
        "/add":(context) => const AddStudents(),
        "/edit":(context) => const EditStudents(),
        "/login":(context) => const LoginPage(),
        "/signup":(context) => const SignUpPage(),
      },
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

/*
Card(
                  elevation: 10,
                  color: Colors.grey,
                  child: Text(
                    snapshot.data?[index]['first_name'] + " " + snapshot.data?[index]['seconds_name'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                      ),
                  ),
                );
*/

/*
SizedBox(
                        width: 300,
                        height: 100,
                        child: Center(child: Text(
                          snapshot.data?[index]['first_name'] + " " + snapshot.data?[index]['seconds_name'],
                        ))),
*/