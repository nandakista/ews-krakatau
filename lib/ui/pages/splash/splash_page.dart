import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/core/app_color.dart';
import 'package:untitled/core/app_style.dart';
import 'package:untitled/ui/pages/home_page/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/app_logo.png'),
              const SizedBox(height: 12),
              Text(
                'Early Warning System',
                style: AppStyle.headline2.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Gunung Anak Krakatau',
                style: AppStyle.subtitle4.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
