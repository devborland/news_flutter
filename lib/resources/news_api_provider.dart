import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
import 'repository.dart';
import 'dart:async';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final responce = await client.get('$_root/topstories.json');
    final ids = json.decode(responce.body);

    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final responce = await client.get('$_root/item/$id.json');
    final parsedJson = jsonDecode(responce.body);

    return ItemModel.fromJson(parsedJson);
  }
}
