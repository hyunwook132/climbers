import 'package:carrot_flutter/src/controllers/feed_controller.dart';
import 'package:carrot_flutter/src/shared/timeutil.dart';
import 'package:carrot_flutter/src/widgets/listitems/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FeedShow extends StatefulWidget {
  final int feedId;
  const FeedShow(this.feedId, {super.key});

  @override
  State<FeedShow> createState() => _FeedShowState();
}

class _FeedShowState extends State<FeedShow> {
  final FeedController feedController = Get.find<FeedController>();
  final RxInt likeCount = 0.obs;
  final RxBool isLiked = false.obs;

  @override
  void initState() {
    super.initState();
    feedController.feedShow(widget.feedId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('피드 상세'),
      ),
      body: Obx(() {
        final feed = feedController.currentFeed.value;
        if (feed == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final textTheme = Theme.of(context).textTheme;

        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        '작성자',
                        style: textTheme.bodyMedium?.copyWith(fontSize: 16.0),
                      ),
                    ),
                    UserListItem(feed.writer!),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '암장이름:',
                                style: textTheme.bodyMedium?.copyWith(fontSize: 16.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  feed.title,
                                  style: textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                '생성시간:',
                                style: textTheme.bodyMedium?.copyWith(fontSize: 14.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  TimeUtil.parse(feed.createdAt),
                                  style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                '이 암장의 특징:',
                                style: textTheme.bodyMedium?.copyWith(fontSize: 16.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  feed.price,
                                  style: textTheme.bodyMedium?.copyWith(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '지점명: ${feedController.currentFeed.value!.content}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 25, fontWeight: FontWeight.bold,),
                ),
              ),
              Text('추천수 : '),
              IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: isLiked.value ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  if (isLiked.value) {
                    likeCount.value--;
                  } else {
                    likeCount.value++;
                  }
                  isLiked.value = !isLiked.value;
                },
              ),
              Text(
                '$likeCount',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }),
    );
  }
}
