import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/screens/home/home.dart';
import 'package:quiz_app/screens/result/result_bloc.dart';
import 'package:quiz_app/utils/strings.dart';

import '../../app/locator.dart';
import '../../services/navigation/navigation_service.dart';
import '../../utils/assets.dart';
import '../leaderboard/leaderboard.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    context.read<ResultBloc>().add(InitResult());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultBloc, ResultState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: state.winStack >= 50
                    ? [Color(0xff205104), Color(0xffa4ecb5)]
                    : [Color(0xffF54927), Color(0xffF09986)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 40),
                        state.winStack >= 50
                            ? Image.asset(Assets.celebration)
                            : Image.asset(Assets.badLuck),

                        Spacer(),
                        textWidget(Strings.resultBoard, 40),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textWidget(Strings.totalQuestion, 20),
                            textWidget(
                              state.totalQuestion.toString(),
                              20,
                              isBold: false,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textWidget(Strings.totalCorrectAnswer, 20),
                            textWidget(
                              state.result.toString(),
                              20,
                              isBold: false,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textWidget(Strings.winStack, 20),
                            textWidget(
                              "${state.winStack} %",
                              20,
                              isBold: false,
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  locator<NavigationService>().pushAndRemoveAll(
                                    Home(),
                                    arguments: {},
                                  );
                                },
                                child: Text(Strings.backToHome),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Leaderboard(),
                                    ),
                                  );
                                },
                                child: Text(Strings.gotoLeaderBoard),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget textWidget(String text, double size, {bool isBold = true}) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
