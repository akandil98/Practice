import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/layout/news_app/cubit/states.dart';
import 'package:practice/modules/business/business_screen.dart';
import 'package:practice/modules/science/science_screen.dart';
import 'package:practice/modules/settings/settings_screen.dart';
import 'package:practice/modules/sports/sports_screen.dart';
import 'package:practice/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '51e49b2369df4ad8a6fda9e9b4c8769d',
      },
    ).then((value) {
      business = value.data['articles'];
      if (kDebugMode) {
        print(business[0]['title']);
      }
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '51e49b2369df4ad8a6fda9e9b4c8769d',
        },
      ).then((value) {
        sports = value.data['articles'];
        if (kDebugMode) {
          print(sports[0]['title']);
        }
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '51e49b2369df4ad8a6fda9e9b4c8769d',
        },
      ).then((value) {
        science = value.data['articles'];
        if (kDebugMode) {
          print(science[0]['title']);
        }
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }
}
