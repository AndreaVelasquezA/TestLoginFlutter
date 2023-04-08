import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hola!,\nAhora puedes habilitar el Login con datos biométricos",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,

              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 270,
              child: ElevatedButton(
                onPressed: () {
          
               Navigator.pushNamed(context, '/auth');

                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 207, 207, 207)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(231, 237, 235, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Empezar!",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ]),
    ));
  }
}
