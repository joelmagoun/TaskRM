import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/widgets/components/custom_image_holder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentTile extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String date;
  final String comment;

  const CommentTile(
      {Key? key,
      required this.imageUrl,
      required this.userName,
      required this.date,
      required this.comment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    String formatUtcDateTime(DateTime utcDateTime) {
      final DateFormat formatter = DateFormat('d MMM');
      return formatter.format(utcDateTime);
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFFF4F5FA)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                  CustomImageHolder(
                    imageUrl: imageUrl,
                    height: 32,
                    width: 32,
                    errorWidget: const Icon(Icons.image)),
                eightHorizontalSpace,
                Text(
                  userName,
                  style: tTextStyle500.copyWith(
                      color: textPrimaryColor, fontSize: 14),
                ),
                const Spacer(),
                Text(
                 formatUtcDateTime(DateTime.parse(date)),
                  style: tTextStyleRegular.copyWith(
                      fontSize: 12, color: iconColor),
                )
              ],
            ),
            eightVerticalSpace,
            Text(
              comment,
              style: tTextStyleRegular.copyWith(
                  fontSize: 14, color: const Color(0xFF555555)),
            )
          ],
        ),
      ),
    );
  }
}
