import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/screens/leaderboard/leaderboard.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';
import 'package:quiz_app/utils/strings.dart';

import '../../app/locator.dart';
import '../../services/database_services/database_services.dart';
import '../../services/navigation/navigation_service.dart';
import '../../utils/assets.dart';
import '../quiz/quiz_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // loadHomaScreen();
    super.initState();
  }

  Future<void> loadHomaScreen() async {
    await locator<DataBaseService>().loadQuestionFromAssets();
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    locator<NavigationService>().pushAndRemoveAll(
                      MyHomePage(),
                      arguments: {},
                    );
                    context.read<MyHomeBloc>().add(InitHome());
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .40,
                    height: 200,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(Strings.quiz, style: TextStyle(fontSize: 20)),
                          Image.asset(Assets.quiz, height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Leaderboard()),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .45,
                    height: 200,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Strings.leaderboard,
                            style: TextStyle(fontSize: 20),
                          ),
                          Image.asset(Assets.leaderboard, height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
