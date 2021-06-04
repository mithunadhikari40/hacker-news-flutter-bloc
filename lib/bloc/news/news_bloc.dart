import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnapp/db/repository.dart';
import 'package:hnapp/models/items_model.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final Repository _repository;

  NewsBloc(this._repository) : super(NewsState());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is GetTopIdEvent) {
      yield NewsState(status: NewsStatus.loading);

      try {
        final ids = await _repository.fetchTopIds();
        yield NewsState(status: NewsStatus.loaded, ids: ids);
      } on Exception {
        yield NewsState(
            status: NewsStatus.error, message: "something went wrong");
      }
    } else if (event is RefreshEvent) {
      yield NewsState(status: NewsStatus.initial);

      try {
        final ids = await _repository.fetchTopIds();
        yield NewsState(status: NewsStatus.loaded, ids: ids);
      } on Exception {
        yield NewsState(
            status: NewsStatus.error, message: "something went wrong");
      }
    }
  }

  Future<ItemModel> getItemModelFuture(int id) {
    return _repository.fetchItem(id);
  }
}
