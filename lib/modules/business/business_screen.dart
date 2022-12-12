import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/layout/news_app/cubit/cubit.dart';
import 'package:practice/layout/news_app/cubit/states.dart';
import 'package:practice/shared/components/componants.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).business;

        return articleBuilder(list);
      },
    );
  }
}
