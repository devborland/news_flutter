import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(left: depth * 16.0, right: 8.0),
            title: buildText(item),
            subtitle: Text(
              item.by,
              style: TextStyle(color: Colors.blue.shade300),
            ),
          ),
          Divider(),
        ];

        item.kids.forEach(
          (kidId) {
            children.add(
              Comment(
                itemId: kidId,
                itemMap: itemMap,
                depth: depth + 1,
              ),
            );
          },
        );

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '\n\n')
        .replaceAll('&quot;', '"')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('<i>', ' ')
        .replaceAll('</i>', ' ')
        .replaceAll('&#x2F;', '/')
        .replaceAll('<a href=', '')
        .replaceAll('&amp;', '&');
    return Text(text);
  }
}
