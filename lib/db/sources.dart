import 'package:hnapp/models/items_model.dart';

abstract class Sources {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> insertItem(ItemModel item);
  Future<int> clearData();
}
