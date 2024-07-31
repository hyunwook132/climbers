import 'package:carrot_flutter/src/controllers/feed_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:carrot_flutter/src/widgets/buttons/category_button.dart';
import 'package:carrot_flutter/src/widgets/listitems/feed_list_item.dart';
import 'create.dart';

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});

  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {
  final feedController = Get.put(FeedController());
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    feedController.feedIndex();
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      feedController.feedIndex(page: ++_currentPage);
      return true;
    }
    return false;
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await feedController.feedIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: '의견 작성',
            child: InkWell(
              onTap: () {
                Get.to(() => const FeedCreate());
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/climbing_wall.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '의견 작성',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('암장별 후기 (객관적인 의견입니다. 참고만 하세요!)'),
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
                SizedBox(width: 30),
                CategoryButton(
                    imagePath: 'assets/images/squat.png', color: Colors.blue),
                SizedBox(width: 30),
                CategoryButton(
                    imagePath: 'assets/images/pull_up.png',
                    color: Colors.green),
                SizedBox(width: 30),
                CategoryButton(
                    imagePath: 'assets/images/running.png', color: Colors.grey),
                SizedBox(width: 12),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => NotificationListener<ScrollNotification>(
                onNotification: _onNotification,
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: feedController.feedList.length,
                    itemBuilder: (context, index) {
                      final item = feedController.feedList[index];
                      return FeedListItem(item);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
