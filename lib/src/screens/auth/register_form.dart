import 'package:carrot_flutter/src/controllers/file_controller.dart';
import 'package:carrot_flutter/src/widgets/buttons/circle_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:carrot_flutter/src/controllers/auth_controller.dart';

import '../home.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final fileController = Get.put(FileController());
  final authController = Get.put(AuthController());
  final _passwordController = TextEditingController();
  final _passwordConfimController = TextEditingController();
  final _nameController = TextEditingController();

  _submit() async {
    bool result = await authController.register(
      _passwordController.text,
      _nameController.text,
      fileController.imageId.value,
    );
    if (result) {
      Get.off(() => const Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            //프로필이미지
            InkWell(
              onTap: fileController.upload,
              child: Obx(() => CircleImage(fileController.imageUrl),),
            ),
            const SizedBox(height: 16),
            // 비밀번호
            Text('비밀번호', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: '비밀번호를 입력해주세요',
              ),
            ),
            // 비밀번호 확인
            const SizedBox(height: 16),
            Text('비밀번호 확인', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordConfimController,
              obscureText: true,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: '비밀번호를 한번 더 입력해주세요',
              ),
            ),
            // 닉네임
            const SizedBox(height: 16),
            Text('닉네임', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: '닉네임을 입력해주세요',
              ),
            ),
            // 버튼
            ElevatedButton(
              onPressed: _submit,
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
