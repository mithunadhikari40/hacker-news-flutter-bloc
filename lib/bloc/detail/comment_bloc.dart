import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnapp/db/repository.dart';
import 'package:hnapp/models/items_model.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final Repository _repository;

  CommentBloc(this._repository)
      : super(CommentState(status: CommentStatus.initial));

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is GetCommentEvent) {
      try {
        final item = _repository.fetchItem(event.id);

        yield await getAnotherState(state, event.id, item);
      } catch (e) {
        yield CommentState(status: CommentStatus.error, message: "$e");
      }
    }
  }

  Future<CommentState> getAnotherState(
      CommentState state, int id, Future<ItemModel> item) async {
    await Future.delayed(Duration.zero);
    final Map<int, Future<ItemModel>> anotherMap = Map.from(state.items);
    anotherMap.putIfAbsent(id, () => item);
    print(
        "Another map data is this one $id, and another map ${anotherMap.keys} and anotherMap $anotherMap");
    return state.copyWith(
      status: CommentStatus.loaded,
      ids: state.ids,
      items: anotherMap,
    );
  }
}
