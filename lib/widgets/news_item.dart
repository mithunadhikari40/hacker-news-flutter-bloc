import 'package:flutter/material.dart';
import 'package:hnapp/core/route_paths.dart';
import 'package:hnapp/models/items_model.dart';
import 'package:hnapp/widgets/loading_container.dart';

class NewsItem extends StatelessWidget {
  final Future<ItemModel> item;
  NewsItem(this.item);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: item,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) return LoadingContainer();
        return buildItem(snapshot.data, context);
      },
    );
  }

  Widget buildItem(ItemModel data, BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(NEWS_DETAIL, arguments: data);
          //todo navigate to the other screen
        },
        title: Text(data.title),
        subtitle: Text("${data.score} votes"),
        trailing: Column(
          children: <Widget>[
            Icon(Icons.comment),
            Text("${data.descendants}"),
          ],
        ),
      ),
    );
  }
}
