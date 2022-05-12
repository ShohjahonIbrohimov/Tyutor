import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/data/repositories/news/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({
    required NewsRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(NewsInitial()) {
    on<StartFetchNews>(_onStartFetchNews);
  }
  final NewsRepository _apiRepository;

  _onStartFetchNews(StartFetchNews event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoading());
      Map<String, dynamic> data = await _apiRepository.getNewsRP(event.page);

      emit(NewsSuccess(
        data: data['data'],
        currentPage: data['currentPage'],
        toPage: data['toPage'],
        lastPage: data['lastPage'],
        total: data['total'],
      ));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
