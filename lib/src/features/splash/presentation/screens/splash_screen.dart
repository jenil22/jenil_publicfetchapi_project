// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jenil_publicfetchapi_project/src/core/constants/image_constants.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image.asset(ImageConstants.logo, scale: 2, fit: BoxFit.contain),
      ),
    );
  }
}
