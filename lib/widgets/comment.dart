import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hnapp/bloc/detail/comment_bloc.dart';
import 'package:hnapp/models/items_model.dart';
import 'package:hnapp/widgets/loading_container.dart';

class Comment extends StatelessWidget {
  final int commentId;
  final int depth;
  final Map<int, Future<ItemModel>> items;
  final CommentBloc bloc;

  const Comment(
      {@required this.commentId,
      @required this.depth,
      @required this.bloc,
      @required this.items});

  @override
  Widget build(BuildContext context) {
    if (items[commentId] == null) {
      bloc.add(GetCommentEvent(commentId));
    }
    print(
        "The state of this bloc is ${items.length} and comment id is $commentId");

    return buildText(items[commentId]);

    // return ListView.builder(
    //   itemCount: state.items.length + 1,
    //   physics: NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   itemBuilder: (BuildContext context, int index) {
    //     // bloc.add(GetDetailEvent(state.ids[index]));
    //     if (index == 0) return buildText(state.items[index]);
    //     print(
    //         "The state of this item is this one ${state.items[index - 1]} and index $index");
    //     // return Text("${state.ids[index]}");
    //     // bloc.itemId(snapshot.data[index]);
    //     // return Comment(commentId: commentId, depth: depth);
    //     return _buildNestedComments(index - 1, state.items[index - 1]);
    //   },
    // );
  }

  Widget _buildNestedComments(int index, Future<ItemModel> item) {
    return FutureBuilder<ItemModel>(
      future: item,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingContainer();
        return Comment(
          commentId: snapshot.data.id,
          depth: depth + 1,
          bloc: bloc,
          items: items,
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: map[commentId],
  //     builder: (BuildContext context, AsyncSnapshot<ItemModel> snpashot) {
  //       if (!snpashot.hasData) {
  //         return LoadingContainer();
  //       }
  //       return Column(
  //         children: <Widget>[
  //           buildText(snpashot.data),
  //           Divider(),
  //           //recursive comment fetching
  //           ...snpashot.data.kids.map((kidId) {
  //             return Comment(commentId: kidId, map: map, depth: depth + 1);
  //           }).toList()
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget buildText(Future<ItemModel> data) {
    return FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) return LoadingContainer();
          return Column(
            children: [
              ListTile(
                  title: Html(
                    data: snapshot.data.text ?? "",
                  ),
                  subtitle: Text(snapshot.data.text == null
                      ? 'Deleted'
                      : 'By: ${snapshot.data.by}'),
                  contentPadding:
                      EdgeInsets.only(right: 16, left: depth * 16.0)),
              Divider(),
              ListView.builder(
                itemCount: snapshot.data.kids.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Comment(
                      depth: depth + 1,
                      bloc: bloc,
                      items: items,
                      commentId: snapshot.data.kids[index]);
                },
              )
            ],
          );
        });
  }
}
