import 'package:flutter/material.dart';
import 'package:movil_quiz/pages/des_auth.dart';
import 'package:movil_quiz/pages/loginScreen.dart';
import 'package:movil_quiz/services/value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../services/local_auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class HabAuth extends StatefulWidget {
  const HabAuth({super.key});

  @override
  _HabAuthState createState() => _HabAuthState();
}

class _HabAuthState extends State<HabAuth> {
 
  //final storage = new FlutterSecureStorage();
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
 

 
 bool authenticated = false;
bool _isLoading = false;
  final TextEditingController emailController = new TextEditingController();
   final TextEditingController passwordController = new TextEditingController();

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
                    if (authenticated){
                      //aqui elimino el 1 token momentaneo
                    //sharedPreferences!.clear();
                    
                    _onButtonPressed();
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
                  child: Text("Habilitar Biometricos"))),
         
        ],
      )),
    );
  }

  void _onButtonPressed(){
    showModalBottomSheet(
      context: context, 
       isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
      builder: (context){
        return Container(
                width: double.infinity,
                height: 400,
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
                          "Confirmar Inicio de Sesión Con Huella",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 151, 150, 150),
                            fontSize: 20,
                            
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
                            onPressed:() {
                              setState(() {
                                _isLoading = true;
                              });
                              signIn(emailController.text, passwordController.text);
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
                      
                 
                      ],
                    )),
             
        );
      });
  }

    signIn(String email, pass) async {
    sharedPreferences!.clear();
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
}
