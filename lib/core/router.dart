import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnapp/bloc/news/news_bloc.dart';
import 'package:hnapp/core/route_paths.dart';
import 'package:hnapp/models/items_model.dart';
import 'package:hnapp/screens/news_detail_screen.dart';
import 'package:hnapp/screens/news_screen.dart';

class Router {
  static MaterialPageRoute generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case NEWS_LIST:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              final bloc = BlocProvider.of<NewsBloc>(context);
              bloc.add(GetTopIdEvent());

              return NewsScreen();
            },
          );
        }
      case NEWS_DETAIL:
        {
          ItemModel news = routeSettings.arguments as ItemModel;
          return MaterialPageRoute(
            builder: (BuildContext context) {
              // final bloc = BlocProvider.of<CommentBloc>(context);
              // bloc.add(GetCommentEvent(newsId));

              return NewsDetail(news);
            },
          );
        }
      default:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                body: Center(
                  child: Text('This route is not defined'),
                ),
              );
            },
          );
        }
    }
  }
}
