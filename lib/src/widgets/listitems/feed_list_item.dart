import 'package:carrot_flutter/src/models/feed_model.dart';
import 'package:carrot_flutter/src/screens/feed/show.dart';
import 'package:carrot_flutter/src/shared/timeutil.dart';
import 'package:carrot_flutter/src/widgets/modal/confirm_modal.dart';
import 'package:carrot_flutter/src/widgets/modal/more_bottom.dart';
import 'package:flutter/material.dart';
import 'package:carrot_flutter/src/controllers/feed_controller.dart';
import 'package:get/get.dart';

const double _imageSize = 110;

class FeedListItem extends StatelessWidget {
  final FeedModel item; //ListView-> Builder변경시 추가된 코드
  const FeedListItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
  final feedController = Get.put(FeedController());

    return InkWell(
      onTap: () {
        Get.to(() => FeedShow(item.id));
      },
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  "https://example.com/image.jpg",
                  width: _imageSize,
                  height: _imageSize,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //'판매할 물건의 제목',
                        item.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Text(
                            '작성일자: ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 8), // Add spacing between the texts
                          Text(
                            TimeUtil.parse(item.createdAt), //'ㅜ분전',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Text(
                        //'물품 가격',
                        item.content,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return MoreBottomModal(
                        cancelTap: () {
                          Get.back();
                        },
                        hideTap: () {},
                        delete: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ConfirmModal(
                                title: '삭제 하기',
                                message: '이 글을 삭제하시겠습니까?',
                                confirmText: '삭제하기',
                                confirmAction: () async {
                                  bool result =
                                      await feedController.feedDelete(item.id);
                                  if (result) {
                                    Get.back();
                                    Get.back();
                                  }
                                },
                                cancel: () {
                                  Get.back();
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 0,
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.grey,
                  size: 16,
                ),
                SizedBox(width: 2),
                Text('1', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 4),
                Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 16,
                ),
                SizedBox(width: 2),
                Text('1', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
