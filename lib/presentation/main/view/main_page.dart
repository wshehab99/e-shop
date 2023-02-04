import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/main/pages/cart_page/view/cart_page_view.dart';
import 'package:sneakers_shop/presentation/main/pages/favorite/favorite_page_view.dart';
import 'package:sneakers_shop/presentation/main/pages/home/view/home_page.dart';
import 'package:sneakers_shop/presentation/main/pages/profile_page/view/profile_page_view.dart';
import 'package:sneakers_shop/presentation/resources/route_manger.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../view_model/main_page_view_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    HomePageView(),
    CartPageView(),
    FavoritePageView(),
    ProfilePageView(),
  ];
  final List<String> _titles = [
    StringManager.discover,
    StringManager.myBag,
    StringManager.favorites,
    StringManager.myProfile,
  ];
  final MainViewModel _mainViewModel = MainViewModel();
  @override
  void dispose() {
    _mainViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _mainViewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _mainViewModel.outputCurrentIndex,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_titles[snapshot.data ?? 0]),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RouteManager.search);
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(RouteManager.notifications);
                    },
                    icon: const Icon(Icons.notifications)),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(SizeManager.s10),
              child: _pages[snapshot.data ?? 0],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _mainViewModel.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: StringManager.discover),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_basket),
                    label: StringManager.myBag),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: StringManager.favorites),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: StringManager.myProfile),
              ],
              onTap: _mainViewModel.setCurrentIndex,
            ),
          );
        });
  }
}
