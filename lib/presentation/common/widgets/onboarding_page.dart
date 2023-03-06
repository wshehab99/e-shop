import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_shop/domain/model/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.page});
  final OnboardingModel page;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          page.title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 30,
              ),
        ).tr(),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          page.imagePath,
          width: 500,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          page.subTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ).tr(),
      ],
    );
  }
}
