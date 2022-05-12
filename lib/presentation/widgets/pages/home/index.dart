import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/news/news_bloc.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/error.dart';
import 'package:moreinfo/presentation/common/loader.dart';
import 'package:moreinfo/presentation/common/nodata.dart';
import 'package:moreinfo/presentation/common/number_pagination.dart';
import 'package:moreinfo/presentation/widgets/pages/home/molecules/news_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var selectedPageNumber = 3;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<NewsBloc>().add(StartFetchNews(1));
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () async {
        context.read<NewsBloc>().add(StartFetchNews(1));
        await Future.delayed(Duration(milliseconds: 500));
        _refreshController.refreshCompleted();
      },
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: Loading());
          } else if (state is NewsSuccess) {
            if (state.data!.isEmpty) {
              return const NoData();
            }
            return SingleChildScrollView(
              child: AppContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ...state.data!.map<NewsCard>((e) {
                      return NewsCard(news: e);
                    }).toList(),
                    NumberPagination(
                      currentPage: state.currentPage,
                      toPage: state.toPage,
                      lastPage: state.lastPage,
                      total: state.total,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            );
          } else if (state is NewsError) {
            return CustomError(text: state.message);
          }
          return Container();
        },
      ),
    );
  }
}
