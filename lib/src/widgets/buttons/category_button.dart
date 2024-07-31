import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String imagePath;  // 이미지 경로를 위한 변수
  final Color color;       // 배경색
  final Color? imageColor; // 이미지 색상

  const CategoryButton({
    required this.imagePath,
    this.onTap,
    required this.color,
    this.imageColor,  // 이미지 색상 추가
    super.key,
  });

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _tapCount++;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              widget.imagePath,
              width: 24,
              height: 24,
              color: widget.imageColor ?? Colors.white, // 이미지 색상 변경
            ),
            const SizedBox(width: 8),
            Text(
              '$_tapCount',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}