import 'package:carrot_flutter/src/controllers/feed_controller.dart';
import 'package:carrot_flutter/src/controllers/file_controller.dart';
import 'package:carrot_flutter/src/models/feed_model.dart';
import 'package:carrot_flutter/src/widgets/buttons/feed_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedEdit extends StatefulWidget {
  final FeedModel model;
  const FeedEdit(this.model, {super.key});

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  final feedController = Get.put(FeedController());
  final fileController = Get.put(FileController());
  // int? imageId;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _contentController = TextEditingController();

  _submit() async {
    final result = await feedController.feedUpdate(
      // 변경
      widget.model.id, // 변경
      _titleController.text,
      _priceController.text,
      _contentController.text,
      fileController.imageId.value,
    );
    if (result) {Get.back();}
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.model.title;
    _priceController.text = widget.model.price.toString();
    _contentController.text = widget.model.content;
    fileController.imageId.value = widget.model.imageId;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('내용 수정')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            const Text('브랜드', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '브랜드를 입력해주세요',
              ),
            ),
            const SizedBox(height: 20),
            const Text('지점명', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '지점명을 입력해주세요',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            const Text('설명', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '설명을 입력해주세요',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('수정하기'),
            ),
          ],
        ),
      ),
    );
  }
}
