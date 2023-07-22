import 'package:animate_do/animate_do.dart';
import 'package:biblioteca_widgets/app/domain/models/slider_item_model.dart';
import 'package:biblioteca_widgets/app/presentation/shared_widgets/slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';

import 'controllers/onboarding_meedu_controller.dart';

final onboardingProvider = SimpleProvider(
  (ref) => OnboardingController(),
);

class OnboardingMeeduScreen extends StatelessWidget {
  const OnboardingMeeduScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer(
            builder: (_, ref, __) {
              final controller = ref.watch(onboardingProvider);
              final pageController = controller.pageViewController;

              // Agregar el callback al inicio del método build
              WidgetsBinding.instance.addPostFrameCallback((_) {
                pageController.addListener(() {
                  controller.onPageChanged();
                });
              });

              return PageView(
                controller:
                    pageController, // Asignar el pageController al PageView
                physics: const BouncingScrollPhysics(),
                children: sliders
                    .map((slide) => SliderWidget(
                          slide: slide,
                        ))
                    .toList(),
              );
            },
          ),
          Positioned(
            right: 20,
            top: 60,
            child: TextButton(
              child: const Text("Skip"),
              onPressed: () {
                onboardingProvider.read.endReached = false;
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: Consumer(
              builder: (_, ref, __) {
                final controller = ref
                    .watch(onboardingProvider
                        .select((controller) => controller.endReached))
                    .endReached;

                return controller
                    ? FadeInRight(
                        from: 15,
                        delay: const Duration(milliseconds: 500),
                        child: FilledButton(
                          child: const Text("Empezar"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
