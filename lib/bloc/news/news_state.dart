part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  List? data;
  int toPage;
  int currentPage;
  int lastPage;
  int total;

  NewsSuccess({
    this.data,
    required this.toPage,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });
}

class NewsError extends NewsState {
  final String message;
  const NewsError(this.message);
}
