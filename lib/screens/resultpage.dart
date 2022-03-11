// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:async';

import 'package:morse/morse.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'package:blinking_morse/screens/homepage.dart';

class MorseCodeResultPage extends StatefulWidget {
  final String message;
  const MorseCodeResultPage({Key? key, required this.message})
      : super(key: key);

  @override
  _MorseCodeResultPageState createState() => _MorseCodeResultPageState();
}

class _MorseCodeResultPageState extends State<MorseCodeResultPage> {
  @override
  Widget build(BuildContext context) {
    final String message = widget.message;
    final Morse morse = new Morse(message);
    String? encodedMessage = morse.encode();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: 120,
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                      children: [
                        const TextSpan(
                            text: 'Here is the ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'morse',
                            style: const TextStyle(color: Color(0xffB79274))),
                        const TextSpan(
                            text: ' code',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    encodedMessage,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              ElevatedButton(
                child: const Text(
                  'FLASH IT',
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
                onPressed: () async {
                  await _lightTheTorch(encodedMessage, context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _enableTorch(BuildContext context) async {
  try {
    await TorchLight.enableTorch();
  } on Exception catch (_) {
    _showMessage('Could not enable torch', context);
  }
}

Future<void> _disableTorch(BuildContext context) async {
  try {
    await TorchLight.disableTorch();
  } on Exception catch (_) {
    _showMessage('Could not disable torch', context);
  }
}

void _showMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future<void> _lightTheTorch(String encodedMessage, BuildContext context) async {
  List<String> result = encodedMessage.split('');

  for (int i = 0; i < result.length; i++) {
    if (result[i] != ' ' && result[i] == '.') {
      _enableTorch(context);

      await Future.delayed(Duration(seconds: 1), () {
        _disableTorch(context);
      });
    } else if (result[i] != ' ' && result[i] == '/') {
      _enableTorch(context);

      await Future.delayed(Duration(seconds: 3), () {
        _disableTorch(context);
      });
    } else if (result[i] != ' ' && result[i] == '-') {
      _enableTorch(context);

      await Future.delayed(Duration(seconds: 2), () {
        _disableTorch(context);
      });
    } else {
      await Future.delayed(Duration(seconds: 1), () {
        _disableTorch(context);
      });
    }
  }
}
