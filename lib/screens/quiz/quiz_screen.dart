import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/screens/quiz/quiz_bloc.dart';
import 'package:quiz_app/utils/strings.dart';

import '../../utils/parse_data_latex.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  // final regex = RegExp(r'\$\$(.*?)\$\$', dotAll: true);
  // final matches = regex.allMatches(question);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyHomeBloc, MyHomeState>(
      builder: (context, state) {
        print(state.currentIndex);
        return Scaffold(
          appBar: AppBar(title: Text(Strings.quizApp)),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${Strings.timeLeft}: ${state.timeLeft} s",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: state.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  // prevent manual swiping
                  itemCount: state.question.length,
                  itemBuilder: (context, index) {
                    final q = state.question[index];
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          parseDataLatex(q.question!),

                          SizedBox(height: 20),
                          ...List.generate(q.options!.length, (i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: q.answer == null
                                        ? Colors.white
                                        : q.answer != i
                                        ? Colors.white
                                        : Color(
                                            0xff5add5b,
                                          ), // Button background color
                                    foregroundColor: q.answer == null
                                        ? Colors.black
                                        : q.answer != i
                                        ? Colors.black
                                        : Colors.white, // Text/Icon color
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<MyHomeBloc>().add(
                                      SetAnswer(index, i),
                                    );
                                  },
                                  child: parseDataLatex(q.options![i]),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Button background color
                    foregroundColor: Colors.white, // Text/Icon color
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    context.read<MyHomeBloc>().add(NeverSubmit());
                  },
                  child: Text(Strings.finishWithout),
                ),
                if ((state.currentIndex + 1) != state.question.length)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      context.read<MyHomeBloc>().add(NextQuestion());
                    },
                    child: Text(Strings.nextQuestion),
                  )
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      context.read<MyHomeBloc>().add(LeaderboardEvent());
                    },
                    child: Text(Strings.finish),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
