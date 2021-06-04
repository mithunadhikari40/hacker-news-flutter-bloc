part of 'news_bloc.dart';

enum NewsStatus { initial, loading, loaded, error }

class NewsState {
  final NewsStatus status;
  final String message;
  final List<int> ids;
  final Map<int, ItemModel> items;

  const NewsState(
      {this.status = NewsStatus.initial,
      this.items = const {},
      this.ids = const [],
      this.message = ''});

  @override
  String toString() {
    return '''NewsState { status: $status, posts: ${items.length} }''';
  }
}
