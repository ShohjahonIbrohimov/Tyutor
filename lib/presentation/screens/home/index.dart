import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/news/news_bloc.dart';
import 'package:moreinfo/data/repositories/news/news_repository.dart';
import 'package:moreinfo/presentation/widgets/pages/home/index.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(apiRepository: NewsRepository()),
      child: NewsPage(),
    );
  }
}
