import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_with_firebase/screens/user_list.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final firebase = FirebaseDatabase.instance;
  final textEditingController = TextEditingController();
  final rootName = "Users"; // root or users table
  var retrievedName = '';

  @override
  Widget build(BuildContext context) {

    final databaseReference = firebase.ref(rootName);

    // listen when new child added to root
    databaseReference.onChildAdded.listen((event) {
      setState(() {
        retrievedName = event.snapshot.value.toString();
      });
    });

    saveName(){
      final dbRef = databaseReference.push();
      dbRef.set({
        "name" : textEditingController.text,
        "email" : 'a@a.com',
        "userName" : "user109034",
        "phoneNumber" : "LPI"
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Text(
            'User Name',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black54
            ),
          ),
          TextField(
            controller: textEditingController,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                saveName();
                textEditingController.clear();
                //retrievedNameFromDB();
              },
              child: const Text('Submit')
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const UsersScreen()));
              },
              child: const Text('Next')
          ),
        ],
      )
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

}
