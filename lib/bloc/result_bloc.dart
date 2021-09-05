import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:github_search/models/repositorie.dart';
import 'package:github_search/service/http_client.dart';
import 'package:meta/meta.dart';

part 'result_event.dart';

part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultInitial());

  late Repositorie repositoriesList;

  @override
  Stream<ResultState> mapEventToState(
    ResultEvent event,
  ) async* {
    if (event is SendRequestEvent) {
      yield ResultInitial();
      try {
        repositoriesList =
            await HttpClient.searchRepositories(seachName: event.repoName);
        yield LoadedState(repoList: repositoriesList, isLoading: false);
      } catch (e) {
        print(e);
      }
    }
    if (event is NextPageEvent) {
      yield LoadingState(repositoriesList, event.isLoading);
      print(event.page);
      try {
        (await HttpClient.searchRepositories(
                seachName: event.repoName, page: event.page))
            .items
            .forEach((element) => repositoriesList.items!.add(element));
        yield LoadedState(repoList: repositoriesList, isLoading: false);
      } catch (e) {
        print(e);
      }
    }
  }
}
