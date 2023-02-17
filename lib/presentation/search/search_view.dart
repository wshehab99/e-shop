import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/resources/pref_manager.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../common/widgets/favorite_card.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringManager.search)),
      body: SingleChildScrollView(
        physics: PrefManager.appScrollPhysics,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
          child: Column(
            children: [
              TextFormField(),
              const SizedBox(height: SizeManager.s10),
              ListView.separated(
                  physics: PrefManager.neverScrollPhysics,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const FavoriteCard(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: SizeManager.s10),
                  itemCount: 10),
            ],
          ),
        ),
      ),
    );
  }
}
