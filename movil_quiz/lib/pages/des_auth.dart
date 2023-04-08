import 'package:flutter/material.dart';
import 'package:movil_quiz/pages/loginScreen.dart';
import 'package:movil_quiz/services/value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '../main.dart';
import '../services/local_auth_service.dart';

class DesHabAuth extends StatefulWidget {
  const DesHabAuth({super.key});

  @override
  _DesHabAuthState createState() => _DesHabAuthState();
}

class _DesHabAuthState extends State<DesHabAuth> {
  final storage = new FlutterSecureStorage();
  //SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    String? token = await storage.read(key: "token");
    if (token == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }
 

  bool authenticated = false;
  bool buttonActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: ElevatedButton(
                  onPressed: () async {
                    final authenticate = await LocalAuth.authenticate();
                    setState(() {
                      authenticated = authenticate;
                    });
                    if (authenticated) { 
                      Value.setString(true);
                        
                    }
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 110, 110, 110)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(231, 237, 235, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ))),
                  child: Text("Deshabilitar"))),
          Container(
              child: ElevatedButton(
                  onPressed: () {
                    storage.deleteAll();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()),
                        (Route<dynamic> route) => false);
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 110, 110, 110)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(231, 237, 235, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ))),
                  child: const Text('Cerrar sesion'))),
        ],
      )),
    );
  }

  /*void active(bool acti){
    
  }*/
}
