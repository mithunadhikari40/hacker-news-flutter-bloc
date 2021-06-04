part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {
  const CommentEvent();
}

class GetCommentEvent extends CommentEvent {
  final int id;
  const GetCommentEvent(this.id);
}
