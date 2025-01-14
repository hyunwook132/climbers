import 'package:carrot_flutter/src/controllers/file_controller.dart';
import 'package:carrot_flutter/src/widgets/buttons/circle_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/forms/label_textfield.dart';

class MyEdit extends StatefulWidget {
  const MyEdit({super.key});

  @override
  State<MyEdit> createState() => _MyeEditState();
}

class _MyeEditState extends State<MyEdit> {
  final userController = Get.put(UserController());
  final fileController = Get.put(FileController());
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = userController.my.value!.name;
    fileController.imageId.value = userController.my.value?.profile;
  }

  _submit() async {
    bool result = await userController.updateInfo(
        _nameController.text, fileController.imageId.value);
    if (result) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          InkWell(
            onTap: fileController.upload,
            child: Obx(
              () => CircleImage(fileController.imageUrl),
            ),
          ),
          const SizedBox(height: 16),
          LabelTextField(
            label: '닉네임',
            hintText: '닉네임을 입력해주세요',
            controller: _nameController,
          ), // 버튼
          ElevatedButton(
            onPressed: _submit,
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }
}
