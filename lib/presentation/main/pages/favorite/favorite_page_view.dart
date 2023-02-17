import 'package:flutter/material.dart';

import '../../../common/widgets/favorite_card.dart';
import '../../../resources/pref_manager.dart';

class FavoritePageView extends StatelessWidget {
  const FavoritePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: PrefManager.appScrollPhysics,
      child: Column(
        children: const [
          FavoriteCard(),
        ],
      ),
    );
  }
}
