import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'src/app.dart';
import 'package:carrot_flutter/src/shared/timeutil.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  // GeStorage 초기화
  await GetStorage.init();

  // TimeAgo 언어 추가
  TimeUtil.init();

  //인증동작
  final box = GetStorage();
  String? token = box.read('access_token');
  bool isLogin = (token != null) ? true : false;

  // final fifteenAgo = DateTime.now().subtract(
  //   Duration(minutes: 15),
  // );
  // print(timeago.format(fifteenAgo));

  runApp(MyApp(isLogin));
}
