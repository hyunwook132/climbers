import 'dart:async';
import 'dart:developer';

import 'package:carrot_flutter/src/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../providers/auth_provider.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  final RxBool isButtonEnable = false.obs;
  final RxBool showVerifyForm = false.obs;
  final authProvider = Get.put(AuthProvider());
  final RxString buttonText = "인증문자 받기".obs;
  String? phoneNumber;
  Timer? countdownTimer;

  Future<bool> register(String password, String name, int? profile) async {
    Map body =
        await authProvider.register(phoneNumber!, password, name, profile);
    if (body['result'] == 'ok') {
      String token = body['access_token'];
      log("token : $token"); // 'dart:developer' 패키지 내의 log 함수
      // Global.accessToken = token;
      await box.write('access_token', token);
      return true;
    }
    Get.snackbar('회원가입 에러', body['message'],
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<bool> login(String phone, String password) async {
    Map body = await authProvider.login(phone, password);
    if (body['result'] == 'ok') {
      String token = body['access_token'];
      log("token : $token"); // 'dart:developer' 패키지 내의 log 함수 Global.accessToken = token;
      // Global.accessToken = token;
      await box.write('access_token', token);
      return true;
    }
    Get.snackbar('로그인 에러', body['message'],
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  //휴대폰 인증 코드를 요청하는 함수
  Future<void> requestVerificationCode(String phone) async {
    Map body = await authProvider.requestPhoneCode(phone);
    if (body['result'] == 'ok') {
      phoneNumber = phone;
      DateTime expiryTime = DateTime.parse(body['expired']);
      _startCountdown(expiryTime);
    }
  }

  //사용자가 입력한 코드를 검증하는 함수
  Future<bool> verifyPhoneNumber(String userInputCode) async {
    Map body = await authProvider.verifyPhoneNumber(userInputCode);
    if (body['result'] == 'ok') {
      return true;
    }
    Get.snackbar('인증번호 에러', body['message'],
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  void _startCountdown(DateTime expiryTime) {
    isButtonEnable.value = false; //버튼 비활성화
    showVerifyForm.value = true; //인증 폼 활성화
    countdownTimer?.cancel(); // 기존 타이머가 있다면 취소

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Duration timeDiff = expiryTime.difference(DateTime.now());
      if (timeDiff.isNegative) {
        buttonText.value = "인증문자 다시 받기";
        isButtonEnable.value = true;
        timer.cancel(); // 타이머 종료
      } else {
        //남은 시간을 mm:ss 포맷으로 업데이트
        String minutes = timeDiff.inMinutes.toString().padLeft(2, '0');
        String seconds = (timeDiff.inSeconds % 60).toString().padLeft(2, '0');
        buttonText.value = "인증문자 다시 받기 $minutes:$seconds";
      }
    });
  }
    void logout() {
    box.remove('access_token'); // 저장된 토큰 삭제
    Get.offAllNamed('/intro'); // 로그인 페이지로 이동
  }


  void updateButtonState(TextEditingController phoneController) {
    String text = phoneController.text.replaceAll('-', '');

    if (text.length <= 3 && !text.startsWith('010')) {
      text = '010';
    } else if (!text.startsWith('010')) {
      text = '010$text';
    }
    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    String formattedText = _formatPhoneNumber(text);
    int cursorPosition = phoneController.selection.baseOffset +
        (formattedText.length - phoneController.text.length);

    phoneController.value = TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
          offset: cursorPosition.clamp(0, formattedText.length)),
    );
    isButtonEnable.value = text.length == 11;
  }

  String _formatPhoneNumber(String text) {
    if (text.length > 7) {
      return '${text.substring(0, 3)}-${text.substring(3, 7)}-${text.substring(7)}';
    } else if (text.length > 3) {
      return '${text.substring(0, 3)}-${text.substring(3)}';
    }
    return text;
  }

  // login(String phone, String password) async {
  //   Map body = await authProvider.login(phone, password);
  //   if (body['result'] == 'ok') {
  //     return true;
  //   }
  //   Get.snackbar('로그인 에러', body['message'],
  //       snackPosition: SnackPosition.BOTTOM);
  //   return false;
  // }
}
