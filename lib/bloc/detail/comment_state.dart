part of 'comment_bloc.dart';

enum CommentStatus { initial, loading, loaded, error }

class CommentState {
  final CommentStatus status;
  final String message;
  final List<int> ids;
  final Map<int, Future<ItemModel>> items;

  const CommentState(
      {this.status = CommentStatus.initial,
      this.items = const {},
      this.ids = const [],
      this.message = ''});

  CommentState copyWith(
      {CommentStatus status,
      Map<int, Future<ItemModel>> items,
      String message,
      List<int> ids}) {
    return CommentState(
      status: status ?? this.status,
      message: message ?? this.message,
      items: items ?? this.items,
      ids: ids ?? this.ids,
    );
  }

  @override
  String toString() {
    return '''CommentState { status: $status, posts: ${items.length} }''';
  }
}
