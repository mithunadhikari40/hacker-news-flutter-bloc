import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnapp/bloc/detail/comment_bloc.dart';
import 'package:hnapp/bloc/news/news_bloc.dart';
import 'package:hnapp/core/route_paths.dart';
import 'package:hnapp/core/router.dart';
import 'package:hnapp/db/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final _repo = Repository();
  runApp(MyApp(_repo));
}

class MyApp extends StatelessWidget {
  final Repository _repo;

  const MyApp(this._repo);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NewsBloc(_repo)),
        BlocProvider(create: (_) => CommentBloc(_repo)),
      ],
      child: MaterialApp(
        title: 'Hacker news app',
        onGenerateRoute: Router.generateRoute,
        initialRoute: NEWS_LIST,
      ),
    );
  }
}
