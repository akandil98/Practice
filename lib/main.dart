import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:practice/layout/news_app/news_layout.dart';
import 'package:practice/shared/bloc_observer.dart';
import 'package:practice/shared/network/remote/dio_helper.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const NewsLayout(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
