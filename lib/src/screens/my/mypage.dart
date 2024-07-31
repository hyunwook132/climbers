import 'package:carrot_flutter/src/controllers/auth_controller.dart';
import 'package:carrot_flutter/src/screens/my/myedit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/listitems/user_mypage.dart';
import 'webpage.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final authController = Get.put(AuthController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필
            Obx(
              () {
                if (userController.my.value == null) {
                  return const CircularProgressIndicator();
                } else {
                  return UserMypage(userController.my.value!);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '나의 정보',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            ListTile(
              title: Text('개인정보 수정'),
              leading: Icon(Icons.receipt_long_outlined),
              onTap: () {
                Get.to(() => const MyEdit());
              },
            ),
            ListTile(
              title: const Text('로그아웃'),
              leading: const Icon(Icons.logout_outlined),
              onTap: () {
                authController.logout();
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('이용약관'),
              onTap: () {
                Get.to(() => const WebPage('이용약관', '/page/terms'));
              },
            ),
            ListTile(
              title: const Text('개인정보 처리방침'),
              onTap: () {
                Get.to(() => const WebPage('개인정보 처리방침', '/page/policy'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
