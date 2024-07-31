import 'package:get/get.dart';
import 'provider.dart';

class FeedProvider extends Provider {
  //피드 리스트(매물목록)
  //@param int page 리스트의 페이지 (1부터 시작)
  //@return Map 피드 목록의 데이터
  //future<map> -> 비동기, 조금 기다렸다가 결국 map이 올거다 라는 의미
  Future<Map> index([int page = 1]) async {
    Response response = await get(
      '/api/feed',
      query: {'page': '$page'},
    );
    return response.body;
  }

  Future<Map> store(
    String title,
    String price,
    String content,
    int? image,
  ) async {
    final Map<String, dynamic> body = {
      'title': title,
      'price': price,
      'content': content,
    };
    if (image != null) {
      body['image'] = image.toString();
    }
    final response = await post('/api/feed', body);
    return response.body;
  }

  Future<Map> update(
    int id,
    String title,
    String price,
    String content,
    int? image,
  ) async {
    final Map<String, dynamic> body = {
      'title': title,
      'price': price,
      'content': content,
    };
    if (image != null) {
      body['image'] = image.toString();
    }

    final response = await put('/api/feed/$id', body);
    return response.body;
  }

  Future<Map> show(int id) async {
    final response = await get('/api/feed/$id');
    return response.body;
  }

  Future<Map> destroy(int id) async {
    final response = await delete('/api/feed/$id');
    return response.body;
  }
}
