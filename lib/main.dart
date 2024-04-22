// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:web_socket_channel/io.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RoomSync',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Room sync app',
      ),
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
  int _counter = 0;
  String ledStatus = "off";
  String fanStatus = "off";
  bool isLoading = false;
  // String ledStatus_from_esp = "off";
  final DBref = FirebaseDatabase.instance.ref();

  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "cheifyofficial@gmail.com", password: "roomautomation");
      // If the sign-in is successful, you can proceed with further actions
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  getLedStatus() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    String uid = currentUser!.uid;
    await DBref.child('UsersData/$uid/readings/light_readings_from_esp/light')
        .onValue
        .listen((event) {
      final dataSnapshot = event.snapshot;

      ledStatus = dataSnapshot.value.toString();
      print(ledStatus);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    isLoading = true;
    signIn();
    isLoading = true;
    getLedStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("RoomSync - Your smart room "),
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Light Status",
                style: TextStyle(color: Colors.deepPurple),
              ),
              SizedBox(
                width: 20,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        buttonPressed_light();
                      },
                      child: Text(ledStatus == 'off' ? 'on' : 'off'))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Fan Status",
                style: TextStyle(color: Colors.deepPurple),
              ),
              SizedBox(
                width: 20,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        buttonPressed_fan();
                      },
                      child: Text(fanStatus == 'off' ? 'on' : 'off'))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "AC Status",
                style: TextStyle(color: Colors.deepPurple),
              ),
              SizedBox(
                width: 20,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        buttonPressed_light();
                      },
                      child: Text(ledStatus == 'off' ? 'on' : 'off'))
            ],
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 20,
          ),
          Mjpeg(
            isLive: true,
            stream: 'http://192.168.163.201:81/stream',
          )
        ]));
  }

  void buttonPressed_light() {
    var currentUser = FirebaseAuth.instance.currentUser;

    String uid = currentUser!.uid;
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    ledStatus == 'off'
        ? DBref.child('UsersData/$uid/readings/light_readings_from_app/light')
            .set("off")
        : DBref.child('UsersData/$uid/readings/light_readings_from_app/light')
            .set("on");

    if (ledStatus == 'off') {
      setState(() {
        ledStatus = 'on';
      });
    } else {
      setState(() {
        ledStatus = 'off';
      });
    }
  }

  void buttonPressed_fan() {
    var currentUser = FirebaseAuth.instance.currentUser;

    String uid = currentUser!.uid;
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    fanStatus == 'off'
        ? DBref.child('UsersData/$uid/readings/fan_readings_from_app/fan')
            .set("off")
        : DBref.child('UsersData/$uid/readings/fan_readings_from_app/fan')
            .set("on");

    if (fanStatus == 'off') {
      setState(() {
        fanStatus = 'on';
      });
    } else {
      setState(() {
        fanStatus = 'off';
      });
    }
  }
}
