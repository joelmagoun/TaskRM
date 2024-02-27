import 'package:flutter/material.dart';

import '../../../../utils/color.dart';
import '../../../../utils/typograpgy.dart';

class FilterOptionTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color checkBoxColor;
  final Color boxBorderColor;

  const FilterOptionTile(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.checkBoxColor,
      required this.boxBorderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: tTextStyleRegular.copyWith(fontSize: 16),
          ),
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
                color: checkBoxColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: boxBorderColor, width: 2)),
            child: const Icon(
              Icons.check,
              color: white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
