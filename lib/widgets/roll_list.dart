import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RollList extends StatelessWidget {
  final double height;
  final String label;
  final bool hasSeeAllButton;
  final Widget tile;

  RollList(
      {required this.height,
      required this.label,
      required this.hasSeeAllButton,
      required this.tile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
              ),
              TextButton(
                  onPressed: () {},
                  child: hasSeeAllButton ? Text('see all >') : Text('')),
            ],
          ),
          SizedBox(
            height: height,
            child: tile,
          )
        ],
      ),
    );
  }
}
