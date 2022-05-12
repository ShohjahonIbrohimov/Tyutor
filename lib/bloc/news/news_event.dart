part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class StartFetchNews extends NewsEvent {
  int page;
  StartFetchNews(this.page);
}
