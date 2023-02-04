import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/main/pages/cart_page/view_model/cart_page_view_model.dart';
import 'package:sneakers_shop/presentation/resources/asset_manager.dart';
import 'package:sneakers_shop/presentation/resources/pref_manager.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../../../../common/widgets/app_divider.dart';
import '../../../../common/widgets/bag_card_list_tail.dart';

import '../../../../resources/size_manager.dart';

class CartPageView extends StatefulWidget {
  const CartPageView({super.key});

  @override
  State<CartPageView> createState() => _CartPageViewState();
}

class _CartPageViewState extends State<CartPageView> {
  final CartPageViewModel _viewModel = CartPageViewModel();
  @override
  void initState() {
    _viewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: PrefManager.appScrollPhysics,
      child: Column(
        children: [
          _buildCard(context),
          _buildRowPrice(context),
          const AppDivider(),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(SizeManager.s10),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(StringManager.next),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return StreamBuilder<List<BagItem>>(
        stream: _viewModel.outputBagItem,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _buildText(context);
          }
          List<BagItem> list = snapshot.data!;

          return ListView.separated(
              separatorBuilder: ((context, index) {
                return const SizedBox(
                  height: SizeManager.s10,
                );
              }),
              itemCount: list.length,
              shrinkWrap: true,
              physics: PrefManager.neverScrollPhysics,
              itemBuilder: (context, index) {
                return BagCardListTail(
                  decreaseItemNumber: () {
                    _viewModel.decreaseItemNumber(index);
                  },
                  increaseItemNumber: () {
                    _viewModel.increaseItemNumber(index);
                  },
                  itemImageUrl: list[index].itemImageUrl,
                  itemName: list[index].itemName,
                  itemPrice: list[index].itemPrice.toString(),
                  numberOfItem: list[index].numberOfItems,
                );
              });
        });
  }

  Widget _buildText(BuildContext context) {
    return Center(
      child: Text(
        StringManager.noItemAdded,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  Widget _buildRowPrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringManager.total,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          StreamBuilder<double>(
              stream: _viewModel.outputTotalPrice,
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData
                      ? "${snapshot.data!.toStringAsFixed(2)} \$"
                      : "0 \$",
                  style: Theme.of(context).textTheme.displayLarge,
                );
              }),
        ],
      ),
    );
  }
}
