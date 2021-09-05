part of 'result_bloc.dart';

@immutable
abstract class ResultState {}

class ResultInitial extends ResultState {}

class LoadingState extends ResultState {
  final Repositorie repoList;
  bool isLoading;

  LoadingState(this.repoList, this.isLoading);
}

class LoadedState extends ResultState {
  final Repositorie repoList;
  bool isLoading;

  LoadedState({required this.repoList, required this.isLoading});
}