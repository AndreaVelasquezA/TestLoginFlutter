import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movil_quiz/pages/des_auth.dart';
import 'package:movil_quiz/pages/hab_auth.dart';
import 'package:movil_quiz/pages/loginScreen.dart';
import 'package:movil_quiz/pages/page1.dart';
import 'package:movil_quiz/pages/profile_screen.dart';
import 'package:movil_quiz/services/local_auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: DesHabAuth(),
      

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences!.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/back.png"), fit: BoxFit.fill)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 36,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 1), //apply padding to all four sides
                  child: Text(
                    '¡Hola!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                    child: ElevatedButton(
                        onPressed: () {
                          sharedPreferences!.clear();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()),
                              (Route<dynamic> route) => false);
                        },
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 110, 110, 110)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(231, 237, 235, 1)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ))),
                        child: const Text('Cerrar sesion'))),
                Expanded(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                    child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        )),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
