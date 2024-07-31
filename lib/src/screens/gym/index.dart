import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/buttons/category_button.dart';

class GymIndex extends StatefulWidget {
  const GymIndex({super.key});

  @override
  State<GymIndex> createState() => _GymIndexState();
}

class _GymIndexState extends State<GymIndex> {
  final RxInt likeCount = 0.obs;
  final RxBool isLiked = false.obs;

  @override
  void initState() {
    super.initState();
  }

  void _showModal(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(''),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('대표 암장들 (클릭하시면 지점이 나옵니다)'),
        actions: [
          IconButton(
            onPressed: () {
              // Search functionality
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Notifications functionality
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                Text(
                  '선호하는 운동을 클릭하세요! \t',
                  style: TextStyle(
                    fontSize: 24.0, // 폰트 크기 설정
                    fontWeight: FontWeight.bold, // 폰트 굵기 설정
                  ),
                ),
                SizedBox(width: 30),
                CategoryButton(
                    imagePath: 'assets/images/push_up.png', color: Colors.red),
                SizedBox(width: 12),
                CategoryButton(
                    imagePath: 'assets/images/squat.png', color: Colors.blue),
                SizedBox(width: 12),
                CategoryButton(
                    imagePath: 'assets/images/pull_up.png', color: Colors.green),
                SizedBox(width: 12),
                CategoryButton(
                    imagePath: 'assets/images/running.png', color: Colors.grey),
                SizedBox(width: 12),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2, // 버튼의 너비는 화면의 절반
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _showModal(context, '논현점, 문래점, 사당점, 신림점, 신사점, 강남점, B 홍대점, 마곡점, 양재점, 연남점, 서울대점, 일산점');
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.blue,
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/the_climb.jpeg',
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    '더클라임',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _showModal(context, '구로점, 종로점, 잠실점, 영등포점, 뚝섬점');
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.green,
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/seoul_forest.jpeg',
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    '서울숲',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _showModal(context, '구로점, 신촌점, 종로점');
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.orange,
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/peakers.jpeg',
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    '피커스',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 오른쪽 절반은 빈 공간
                Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
