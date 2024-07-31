import 'package:carrot_flutter/src/controllers/feed_controller.dart';
import 'package:carrot_flutter/src/controllers/file_controller.dart';
import 'package:carrot_flutter/src/widgets/buttons/feed_image.dart';
import 'package:carrot_flutter/src/widgets/forms/label_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedCreate extends StatefulWidget {
  const FeedCreate({super.key});
  @override
  State<FeedCreate> createState() => _FeedCreateState();
}

class _FeedCreateState extends State<FeedCreate> {
  final feedController = Get.put(FeedController());
  final fileController = Get.put(FileController());
  // int? imageId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  _submit() async {
    final result = await feedController.feedCreate(
      _titleController.text,
      _contentController.text,
      _priceController.text,
      fileController.imageId.value,
    );
    if (result) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('암장 추천하기')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: fileController.upload,
                        child: Obx(() => FeedImage(fileController.imageUrl),),
                      )
                    ],
                  ),
                  const SizedBox(height: 16), // 제목
                  LabelTextField(
                    label: '암장 브랜드',
                    hintText: '브랜드 명을 입력해주세요.(ex. 더클라임, 피커스 등)',
                    controller: _titleController,
                  ),
                  LabelTextField(
                    label: '지점명',
                    hintText: '지점명을 입력해주세요.(ex. 강남점, 연남점 등)',
                    controller: _priceController,
                  ),
                  LabelTextField(
                    label: '설명',
                    hintText: '이 암장은 어떤 곳인가요?',
                    controller: _contentController,
                    maxLines: 6,
                  ),
                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('작성 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
