import 'package:carrot_flutter/src/models/user_model.dart';

import '../shared/global.dart';

class FeedModel {
  late int id;
  late String title;
  late String content;
  late String price;
  int? imageId;
  DateTime? createdAt; // 추가
  bool isMe = false; // 추가
  UserModel? writer; // 추가

  get imageUrl => (imageId != null)
      ? "${Global.baseUrl}/file/$imageId"
      : "https://example.com/image.jpg";

  FeedModel({
    required this.id,
    required this.title,
    required this.content,
    required this.price,
    this.imageId,
    required this.createdAt,
    required this.isMe, // 추가
    this.writer, // 추가
  });

  FeedModel.parse(Map m) {
    id = m['id'];
    title = m['title'];
    content = m['content'];
    price = m['price'];
    imageId = m['image_id'];
    createdAt = DateTime.parse(m['created_at']);
    isMe = m['is_me'] ?? false;
    writer = (m['writer'] != null) ? UserModel.parse(m['writer']) : null;
    }
  FeedModel copyWith({
    int? id,
    String? title,
    String? content,
    String? price,
    int? imageId,
    DateTime? createdAt,
    bool? isMe,
    UserModel? writer,
  }) {
    return FeedModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      price: price ?? this.price,
      imageId: imageId ?? this.imageId,
      createdAt: createdAt ?? this.createdAt,
      isMe: isMe ?? this.isMe,
      writer: writer ?? this.writer,
    );
  }
}