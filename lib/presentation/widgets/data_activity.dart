import 'package:flutter/material.dart';
import '../../generated/assets.dart';

class DataActivity {
  // emptyData --
  static Widget emptyData(
    context, {
    String? imgName,
    String? title,
    String? subtitle,
  }) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imgName ?? Assets.imagesDoDataFound, height: 160),
          Text(
            textAlign: TextAlign.center,
            title ?? "No Data Available",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            textAlign: TextAlign.center,
            subtitle ?? "There is no data to show you right now.",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  // something went wrong -- >
  static Widget somethingWentWrong(
    context, {
    String? imgName,
    String? title,
    String? subtitle,
  }) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imgName ?? Assets.imagesSomethingWentWrong, height: 160),
          Text(
            textAlign: TextAlign.center,
            title ?? "Something Went Wrong!",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            textAlign: TextAlign.center,
            subtitle ?? "Unable to connect right now. Try again later.",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
