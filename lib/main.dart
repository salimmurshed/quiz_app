import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz/quiz_bloc.dart';
import 'package:quiz_app/screens/result/result.dart';
import 'package:quiz_app/screens/result/result_bloc.dart';
import 'package:quiz_app/screens/splash_screen/splash_screen.dart';
import 'package:quiz_app/services/navigation/navigation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/locator.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyHomeBloc>(
          create: (BuildContext context) => MyHomeBloc(),
        ),
        BlocProvider<ResultBloc>(
          create: (BuildContext context) => ResultBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: locator<NavigationService>().navigatorKey,
        title: 'QUIZ APP',
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
          ),
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
