import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/bloc/result_bloc.dart';
import 'package:github_search/constants.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'components/repo_info_card.dart';

class SearchResultScreen extends StatefulWidget {
  final String repoName;

  const SearchResultScreen({Key? key, required this.repoName})
      : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final controller = ScrollController();
  int page = 1;
  late ResultBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ResultBloc>(context);
    controller.addListener(onScroll);
    super.initState();
    initializeDateFormatting();
  }

  void onScroll() {
    if (bloc.state is LoadedState == false) return;
    if (!controller.hasClients) return;
    final double maxHeight = controller.position.maxScrollExtent;
    final double currentHeight = controller.offset;
    if (currentHeight >= maxHeight * 0.9) {
      bloc.add(
        NextPageEvent(
          repoName: widget.repoName,
          page: ++page,
          isLoading: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Результат поиска".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 19,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "По запросу: ".toUpperCase(),
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                '"${widget.repoName.toUpperCase()}"',
                style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          BlocBuilder<ResultBloc, ResultState>(builder: (context, state) {
            if (state is ResultInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadedState) {
              return Expanded(
                child: builResult(state),
              );
            }
            if (state is LoadingState) {
              return Expanded(
                child: builResult(state),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ],
      ),
    );
  }

  Widget builResult(var state) {
    return Column(
      children: [
        Text(
          "Найдено: ${state.repoList.totalCount}".toUpperCase(),
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(
          height: 19,
        ),
        Expanded(
          child: ListView.builder(
            controller: controller,
            itemCount: state.repoList.items.length,
            itemBuilder: (context, index) => RepoInfoCard(
              repositorie: state.repoList,
              index: index,
            ),
          ),
        ),
        Container(
          height: state.isLoading ? 40.0 : 0,
          color: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
