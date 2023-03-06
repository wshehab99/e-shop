import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_shop/app/dependency_injection.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/main/pages/cart_page/view_model/cart_page_view_model.dart';
import 'package:sneakers_shop/presentation/main/pages/favorite/view_model/favorite_page_view_model.dart';
import 'package:sneakers_shop/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:sneakers_shop/presentation/main/pages/profile_page/view_model/profile_view_model.dart';
import '../../resources/route_manger.dart';
import '../../resources/size_manager.dart';
import '../../resources/string_manager.dart';
import '../pages/cart_page/view/cart_page_view.dart';
import '../pages/favorite/view/favorite_page_view.dart';
import '../pages/home/view/home_page.dart';
import '../pages/profile_page/view/profile_page_view.dart';
import '../view_model/main_page_view_model.dart';
import '../../../app/app_extensions.dart';

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
  final MainViewModel _mainViewModel =
      DependencyInjection.instance<MainViewModel>();
  final HomeViewMode1 _homeViewModel =
      DependencyInjection.instance<HomeViewMode1>();
  final CartPageViewModel _cartViewModel =
      DependencyInjection.instance<CartPageViewModel>();
  final FavoritePageViewModel _favoriteViewModel =
      DependencyInjection.instance<FavoritePageViewModel>();
  final ProfilePageViewModel _settingsViewModel =
      DependencyInjection.instance<ProfilePageViewModel>();
  @override
  void dispose() {
    _mainViewModel.dispose();
    _cartViewModel.dispose();
    _favoriteViewModel.dispose();
    _settingsViewModel.dispose();
    _homeViewModel.dispose();
    super.dispose();
  }
  _binding()async{
_mainViewModel.init();
   await _homeViewModel.init();
  await  _cartViewModel.init();
   await _favoriteViewModel.init();
  await  _settingsViewModel.init();
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContent(context);
  }

  Widget _getContent(BuildContext context) => StreamBuilder<int>(
      stream: _mainViewModel.outputCurrentIndex,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_titles[snapshot.data.orZero()]).tr(),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteManager.search);
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteManager.notifications);
                  },
                  icon: const Icon(Icons.notifications)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(SizeManager.s10),
            child: _pages[snapshot.data.orZero()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: snapshot.data.orZero(),
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
