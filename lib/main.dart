import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/bloc/result_bloc.dart';

import 'ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResultBloc>(
      create: (context) => ResultBloc()..add(LoadingEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GitHub Search',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'SFProDisplay',
        ),
        home: SplashScreen(),
      ),
    );
  }
}

