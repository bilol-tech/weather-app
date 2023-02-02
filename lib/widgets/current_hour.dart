import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowCurrentTime extends StatelessWidget {
  final bool isActive;
  final String? title;
  final String? image;
  final num? temp;
  const ShowCurrentTime(
      {super.key, required this.isActive, this.title, this.image, this.temp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Container(
        width: 70.w,
        decoration: BoxDecoration(
          color: isActive ? Color(0xff48319D) : Color.fromARGB(80, 85, 61, 170),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: [
            16.verticalSpace,
            Text(
              (title ?? "").substring((title ?? "").indexOf(" ") + 1),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            12.verticalSpace,
            Image.network('https:${image ?? ''}'),
            14.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (temp ?? 0)
                      .toString()
                      .substring(0, (temp ?? 0).toString().indexOf('.')),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  '°',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
