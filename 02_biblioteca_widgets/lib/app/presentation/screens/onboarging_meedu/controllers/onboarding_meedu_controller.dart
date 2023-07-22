import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';

import '../../../../domain/models/slider_item_model.dart';

class OnboardingController extends SimpleNotifier {
  final PageController pageViewController = PageController();
  bool endReached = false;

  void onPageChanged() {
    final page = pageViewController.page ?? 0;
    if (page >= (sliders.length - 1.5)) {
      endReached = true;
    } else {
      endReached = false;
    }
    notify();
  }
}
