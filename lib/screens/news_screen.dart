import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnapp/bloc/news/news_bloc.dart';
import 'package:hnapp/widgets/news_item.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest News"),
      ),
      body: _buildNewsList(context),
    );
  }

  Widget _buildNewsList(BuildContext context) {
    final bloc = BlocProvider.of<NewsBloc>(context);
    bloc.add(GetTopIdEvent());
    return BlocConsumer<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state.status == NewsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (BuildContext context, NewsState state) {
        if (state.status == NewsStatus.initial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status == NewsStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status == NewsStatus.error) {
          return Center(child: Text(state.message));
        }

        return RefreshIndicator(
          onRefresh: () async {
            bloc.add(RefreshEvent());
          },
          child: ListView.builder(
            itemCount: state.ids.length,
            itemBuilder: (BuildContext context, int index) {
              // bloc.add(GetDetailEvent(state.ids[index]));
              // return Text("${state.ids[index]}");
              // bloc.itemId(snapshot.data[index]);
              final future = bloc.getItemModelFuture(state.ids[index]);
              return NewsItem(future);
            },
          ),
        );
      },
    );
  }
}
