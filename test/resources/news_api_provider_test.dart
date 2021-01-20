import 'package:flutter_test/flutter_test.dart';
import 'package:news_flutter/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test(
    'FetchTopIds returns a list of ids',
    () async {
      // arrange  // setup of test case
      final newsApi = NewsApiProvider();
      newsApi.client = MockClient(
        (request) async {
          return Response(jsonEncode([1, 2, 3, 4]), 200);
        },
      );

      final ids = await newsApi.fetchTopIDs();

      // act //expectation
      expect(ids, [1, 2, 3, 4]);
      // assert
    },
  );

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient(
      (request) async {
        final jsonMap = {'id': 123};
        return Response(jsonEncode(jsonMap), 200);
      },
    );

    final item = await newsApi.fetchItem(999999);

    expect(item.id, 123);
  });
}
