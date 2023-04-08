import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movil_quiz/main.dart';
import 'package:movil_quiz/pages/des_auth.dart';
import 'package:movil_quiz/pages/hab_auth.dart';
import 'package:movil_quiz/pages/page1.dart';
import 'package:movil_quiz/pages/profile_screen.dart';
import 'package:movil_quiz/services/local_auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:movil_quiz/services/usuario.dart';
import 'package:movil_quiz/services/value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  //CAPTURAR LA INFO DE LOS INPUT

  bool buttonActive = Value.getString();
  int sesion = 1;
  bool authenticated = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
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
              image: AssetImage("images/back.png"), fit: BoxFit.cover)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                    color: Colors.white,
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
                        Text(
                          "Login",
                          style: TextStyle(
                            color: Color.fromARGB(255, 151, 150, 150),
                            fontSize: 45,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: emailController,
                          //keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Color(0xFFe7edeb),
                              hintText: "Username",
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: Colors.grey[600],
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          //keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Color.fromRGBO(231, 237, 235, 1),
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.password,
                                color: Colors.grey[600],
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 270,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              Usuario.setString(emailController.text,passwordController.text);
                              signIn(emailController.text,
                                  passwordController.text);
                            },
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 207, 207, 207)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(231, 237, 235, 1)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                ))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "Iniciar Sesión",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (Value.getString() == false) {
                                    setState(() {
                                      buttonActive = true;
                                    });
                                    final authenticate =
                                        await LocalAuth.authenticate();
                                    setState(() {
                                      authenticated = authenticate;
                                    });
                                    if (authenticated) {
                                      signInHuella(Usuario.usuarioEmail(), Usuario.usuarioPass());
                                    }
                                  } else {
                                    habilitar();
                                  }
                                },
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 110, 110, 110)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(231, 237, 235, 1)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28.0),
                                    ))),
                                child: const Text(
                                    'Iniciar con datos Biometricos'))),
                      ],
                    )),
              ),
            ),
          ]),
    ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var jsonResponse = null;

    var response = await http
        .post(Uri.parse('http://192.168.20.26:3000/signin'), body: data);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HabAuth()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  signInHuella(String email, pass) async {
    Value.setString(false);
      //2 token
    final storage = new FlutterSecureStorage();
    Map data = {'email': email, 'password': pass};
    var jsonResponse = null;

    var response = await http.post(Uri.parse('http://192.168.20.26:3000/signin'), body: data);
    
    if(response.statusCode == 200){
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
     

      if (jsonResponse != null) {
      setState(() {
        _isLoading = false;
      });
      
      await storage.write(key: "token", value: jsonResponse["token"]);
      
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => DesHabAuth()),(Route<dynamic> route) => false);
        }
    }
    
     else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  void habilitar() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (context) {
          return Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
                color: Colors.white,
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
                    Text(
                      "El inicio de sesion con datos biometricos aun no se ha configurado",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 151, 150, 150),
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
