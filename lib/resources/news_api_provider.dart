import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();
  fetchTopIDs() async {
    final responce = await client.get(
      '$_root/topstories.json',
    );
    final ids = json.decode(responce.body);
    return ids;
  }

  fetchItem(int id) async {
    final responce = await client.get('$_root/item/$id.json');
    final parsedJson = jsonDecode(responce.body);
    return ItemModel.fromJson(parsedJson);
  }
}
