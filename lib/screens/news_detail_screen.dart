import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnapp/bloc/detail/comment_bloc.dart';
import 'package:hnapp/models/items_model.dart';
import 'package:hnapp/widgets/comment.dart';
import 'package:hnapp/widgets/loading_container.dart';

class NewsDetail extends StatefulWidget {
  final ItemModel item;
  NewsDetail(this.item);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
      ),
      body: Column(
        children: [
          buildTitle(),
          SizedBox(
            height: 8,
          ),
          buildCommentsBody(context),
        ],
      ),
    );
  }

  Widget buildCommentsBody(BuildContext context) {
    final bloc = BlocProvider.of<CommentBloc>(context);
    bloc.add(GetCommentEvent(widget.item.id));
    return BlocConsumer<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state.status == CommentStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (BuildContext context, CommentState state) {
        counter++;
        print("Yeha kati patak aucha $counter");

        if (state.status == CommentStatus.initial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status == CommentStatus.loading) {
          return Center(child: LoadingContainer());
        }
        if (state.status == CommentStatus.error) {
          return Center(child: Text(state.message));
        }
        return Flexible(
          fit: FlexFit.loose,
          child: ListView.builder(
            itemCount: widget.item.kids.length,
            itemBuilder: (BuildContext context, int index) {
              return Comment(
                commentId: widget.item.kids[index],
                depth: 1,
                items: state.items,
                bloc: bloc,
              );
            },
          ),
        );
      },
    );
    // print("Kids of this item are ${item.kids}");
    // return ListView.builder(
    //   itemCount: item.kids.length + 1,
    //   itemBuilder: (BuildContext context, int index) {
    //     if (index == 0) return buildTitle();

    //     return Comment(commentId: item.kids[index - 1], depth: 1);
    //   },
    // );
  }

  Widget buildTitle() {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(16),
      child: Text(
        widget.item.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
