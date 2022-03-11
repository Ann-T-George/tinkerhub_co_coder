// ignore_for_file: prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace

import 'package:blinking_morse/animations/loadingAnimation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController morseController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Logo of the app
              Image.asset(
                'assets/images/logo.png',
                height: 120,
              ),

              //Type your Text here(refer the documentation for more info or the code)
              Column(
                children: [
                  Text(
                    "TYPE SOMETHING",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    // ignore: prefer_const_constructors
                    child: TextField(
                      controller: morseController,
                      // ignore: prefer_const_constructors
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //Use elevatedbutton widget for the button

              ElevatedButton(
                child: const Text(
                  'CONVERT',
                  style: TextStyle(fontSize: 22),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff04E474)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(const Size(204, 46)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                onPressed: () {
                  //Going to the loading animation and passing the message
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RotatedArrowAnimation(
                              text: morseController.text)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
