
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: .5, color: AppColors.darkGrey)),
    );
  }
}
