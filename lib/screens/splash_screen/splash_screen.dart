import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/app/locator.dart';
import 'package:quiz_app/services/navigation/navigation_service.dart';

import '../../services/database_services/database_services.dart';
import '../../utils/assets.dart';
import '../home/home.dart';
import '../quiz/quiz_bloc.dart';
import '../quiz/quiz_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadHomaScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: Image.asset(Assets.splashBg, fit: BoxFit.fill),
          ),
          Center(
            child: Text(
              "Quiz App",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadHomaScreen() async {
    await locator<DataBaseService>().loadQuestionFromAssets();
    await Future.delayed(Duration(seconds: 1));
    locator<NavigationService>().pushAndRemoveAll(Home(), arguments: {});
  }
}
