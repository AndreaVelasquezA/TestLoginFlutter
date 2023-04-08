import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  

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
                  image: AssetImage("images/back.png"),
                  fit: BoxFit.fill)),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
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
