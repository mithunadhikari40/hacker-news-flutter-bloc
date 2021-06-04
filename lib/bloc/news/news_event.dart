part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {
  const NewsEvent();
}

class GetTopIdEvent extends NewsEvent {
  const GetTopIdEvent();
}

class RefreshEvent extends NewsEvent {
  const RefreshEvent();
}

class GetDetailEvent extends NewsEvent {
  final int id;
  const GetDetailEvent(this.id);
}
