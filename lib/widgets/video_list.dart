import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/constants.dart';
import '../services/fetch_thumbnails.dart';

class ExcVidList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: urlList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Uri url = Uri.parse(urlList[index]);
            launchUrl(url);
          },
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.white70, BlendMode.hue),
                    child: Image.network(
                      getYoutubeThumbnail(urlList[index]),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Icon(
                    Icons.play_circle_outline_sharp,
                    color: Color.fromRGBO(255, 255, 255, 30),
                    size: 30.sp,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
