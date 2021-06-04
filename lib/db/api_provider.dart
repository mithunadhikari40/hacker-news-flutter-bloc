import 'dart:convert';
import 'package:hnapp/core/constants.dart';
import 'package:hnapp/db/sources.dart';
import 'package:hnapp/models/items_model.dart';
import 'package:http/http.dart';

class ApiProvider implements Sources {
  Client client = Client();
  @override
  Future<List<int>> fetchTopIds() async {
    final uri = Uri.parse("$BASE_URL/topstories.json");
    final response = await client.get(uri);
    return jsonDecode(response.body).cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final uri = Uri.parse("$BASE_URL/item/$id.json");

    final response = await client.get(uri);
    return ItemModel.fromJson(jsonDecode(response.body));
  }
}
