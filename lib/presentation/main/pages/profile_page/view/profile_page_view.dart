import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/main/pages/profile_page/view_model/profile_view_model.dart';
import 'package:sneakers_shop/presentation/resources/asset_manager.dart';
import 'package:sneakers_shop/presentation/resources/color_manger.dart';
import 'package:sneakers_shop/presentation/resources/pref_manager.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final ProfilePageViewModel _viewModel = ProfilePageViewModel();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileDetails(context),
            const SizedBox(
              height: SizeManager.s10,
            ),
            _getText(context: context, text: StringManager.dashboard),
            const SizedBox(
              height: SizeManager.s10,
            ),
            _buildListTile(
                context: context,
                leadingIcon: Icons.payment,
                title: StringManager.payment,
                trailingText: StringManager.new2,
                onTap: () {}),
            const SizedBox(
              height: SizeManager.s10,
            ),
            _buildListTile(
              context: context,
              leadingIcon: Icons.archive,
              title: StringManager.achievements,
              leadingColor: ColorManager.deepGreen,
            ),
            const SizedBox(
              height: SizeManager.s10,
            ),
            _buildListTile(
              context: context,
              leadingIcon: Icons.privacy_tip_outlined,
              title: StringManager.privacy,
              trailingText: StringManager.actionNeeded,
              trailingColor: ColorManager.error,
              leadingColor: ColorManager.lightGrey,
            ),
            const SizedBox(
              height: SizeManager.s10,
            ),
            _getText(context: context, text: StringManager.settings),
            const SizedBox(
              height: SizeManager.s10,
            ),
            _buildListTile(
              context: context,
              leadingIcon: Icons.language,
              title: StringManager.changeLanguage,
              leadingColor: ColorManager.blue,
            ),
            const SizedBox(
              height: SizeManager.s10,
            ),
            _buildListTile(
              context: context,
              leadingIcon: Icons.dark_mode,
              title: StringManager.darkMode,
              leadingColor: ColorManager.darkGrey,
            ),
            const SizedBox(
              height: SizeManager.s10,
            ),
            _getText(context: context, text: StringManager.myAccount),
            const SizedBox(
              height: SizeManager.s10,
            ),
            _getTextButton(
                context: context,
                text: StringManager.switchToOtherAccount,
                onPressed: _viewModel.switchToOtherAccount),
            _getTextButton(
                context: context,
                text: StringManager.logOut,
                isError: true,
                onPressed: _viewModel.logout)
          ],
        ));
  }

  Widget _getTextButton(
      {required BuildContext context,
      required String text,
      required void Function()? onPressed,
      bool isError = false}) {
    return TextButton(
      onPressed: onPressed,
      style: Theme.of(context).textButtonTheme.style!.copyWith(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: isError ? ColorManager.error : ColorManager.blue,
            ),
      ),
    );
  }

  Widget _getText({required BuildContext context, required String text}) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headlineLarge!
          .copyWith(color: ColorManager.lightGrey),
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: PrefManager.appScrollPhysics,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(AssetImageManager.profilePic),
            radius: SizeManager.s35,
          ),
          const SizedBox(
            width: SizeManager.s10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Waleed Bin Shehab",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Junior Developer",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(
            width: SizeManager.s10,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: ColorManager.lightGrey,
              ))
        ],
      ),
    );
  }

  Widget _buildListTile(
      {required BuildContext context,
      required IconData leadingIcon,
      required String title,
      void Function()? onTap,
      String? trailingText,
      Color trailingColor = ColorManager.darkGrey,
      Color leadingColor = ColorManager.lightPrimary}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: leadingColor,
        child: Icon(
          leadingIcon,
          color: ColorManager.offWhite,
        ),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: trailingText != null
          ? Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.s8, vertical: SizeManager.s4),
              decoration: BoxDecoration(
                color: trailingColor,
                borderRadius: BorderRadius.circular(SizeManager.s16),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  trailingText,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: ColorManager.white),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.white,
                  size: SizeManager.s10,
                )
              ]),
            )
          : const Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.lightGrey,
              size: SizeManager.s20,
            ),
    );
  }
}
