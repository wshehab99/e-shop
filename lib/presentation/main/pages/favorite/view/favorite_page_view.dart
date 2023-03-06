import 'package:flutter/material.dart';
import 'package:sneakers_shop/app/dependency_injection.dart';
import 'package:sneakers_shop/domain/model/favorite_model.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/main/pages/favorite/view_model/favorite_page_view_model.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';

import '../../../../common/widgets/favorite_card.dart';
import '../../../../resources/pref_manager.dart';

class FavoritePageView extends StatefulWidget {
   FavoritePageView({super.key});

  @override
  State<FavoritePageView> createState() => _FavoritePageViewState();
}

class _FavoritePageViewState extends State<FavoritePageView> {
  final FavoritePageViewModel _viewModel =
      DependencyInjection.instance<FavoritePageViewModel>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.renderWidget(context, _getContent()) ??
              _getContent();
        });
  }

  Widget _getContent() {
    return StreamBuilder<FavoriteModel>(
        stream: _viewModel.outputFavorite,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.separated(
                  physics: PrefManager.appScrollPhysics,
                  itemBuilder: (context, index) {
                    return FavoriteCard(
                      product: snapshot.data!.favorite[index],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: SizeManager.s10,
                  ),
                  itemCount: snapshot.data?.favorite.length ?? 0,
                )
              : const SizedBox(
                  height: SizeManager.s10,
                );
        });
  }
}
