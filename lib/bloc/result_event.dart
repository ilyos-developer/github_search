part of 'result_bloc.dart';

@immutable
abstract class ResultEvent {}

class LoadingEvent extends ResultEvent {}

class SendRequestEvent extends ResultEvent {
  final String repoName;

  SendRequestEvent({required this.repoName});
}

class NextPageEvent extends ResultEvent {
  final String repoName;
  int page;
  bool isLoading;

  NextPageEvent(
      {required this.repoName, required this.page, required this.isLoading});
}
