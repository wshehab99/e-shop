import 'package:flutter/material.dart';
import 'package:sneakers_shop/app/dependency_injection.dart';
import 'package:sneakers_shop/domain/model/settings_model.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/main/pages/profile_page/view_model/profile_view_model.dart';
import 'package:sneakers_shop/presentation/resources/color_manger.dart';
import 'package:sneakers_shop/presentation/resources/pref_manager.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';
import 'package:sneakers_shop/presentation/resources/them_manager/view_model/theme_view_model.dart';

import '../../../../../domain/model/authentication_model.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final ProfilePageViewModel _viewModel =
      DependencyInjection.instance<ProfilePageViewModel>();
  final ThemeMangerViewModel _themeViewModel =
      DependencyInjection.instance<ThemeMangerViewModel>();
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
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.renderWidget(context, _getContent()) ??
              _getContent();
        });
  }

  Widget _getContent() {
    return SingleChildScrollView(
        physics: PrefManager.appScrollPhysics,
        child: StreamBuilder<SettingsModel>(
            stream: _viewModel.outputSettings,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileDetails(
                            context, snapshot.data!.data.contact),
                        const SizedBox(
                          height: SizeManager.s10,
                        ),
                        _getText(
                            context: context, text: StringManager.dashboard),
                        const SizedBox(
                          height: SizeManager.s10,
                        ),
                        _buildListTile(
                          context: context,
                          leadingIcon: Icons.payment,
                          title: StringManager.payment,
                          list: snapshot.data!.data.payment,
                          stream: _viewModel.outputPaymentShown,
                          newList: snapshot.data!.data.newPayment,
                          trailingText: StringManager.new2,
                          onTap: _viewModel.showUnShowPayment,
                        ),
                        const SizedBox(
                          height: SizeManager.s10,
                        ),
                        _buildListTile(
                          context: context,
                          leadingIcon: Icons.archive,
                          title: StringManager.achievements,
                          list: snapshot.data!.data.achievement,
                          stream: _viewModel.outputAchievementShown,
                          newList: snapshot.data!.data.newAchievement,
                          onTap: _viewModel.showUnShowAchievement,
                          leadingColor: ColorManager.deepGreen,
                        ),
                        const SizedBox(
                          height: SizeManager.s10,
                        ),
                        _buildListTile(
                            context: context,
                            leadingIcon: Icons.privacy_tip_outlined,
                            title: StringManager.privacy,
                            list: snapshot.data!.data.privacy,
                            newList: [],
                            stream: _viewModel.outputPrivacyShown,
                            trailingText: StringManager.actionNeeded,
                            trailingColor: ColorManager.error,
                            leadingColor: ColorManager.lightGrey,
                            onTap: _viewModel.showUnShowPrivacy),
                        const SizedBox(
                          height: SizeManager.s10,
                        ),
                        _getText(
                            context: context, text: StringManager.settings),
                        const SizedBox(
                          height: SizeManager.s10,
                        ),
                        _buildListTile(
                            context: context,
                            leadingIcon: Icons.language,
                            title: StringManager.changeLanguage,
                            list: [],
                            newList: [],
                            stream: _viewModel.outputLanguagesShown,
                            leadingColor: ColorManager.blue,
                            onTap: _viewModel.showUnShowLanguages),
                        const SizedBox(
                          height: SizeManager.s10,
                        ),
                        _buildListTile(
                            context: context,
                            leadingIcon: Icons.dark_mode,
                            title: StringManager.darkMode,
                            list: [],
                            newList: [],
                            stream: _themeViewModel.isDarkOutput,
                            leadingColor: ColorManager.darkGrey,
                            onTap: _themeViewModel.changeTheme),
                        const SizedBox(
                          height: SizeManager.s10,
                        ),
                        _getText(
                            context: context, text: StringManager.myAccount),
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
                    )
                  : const SizedBox();
            }));
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

  Widget _buildProfileDetails(
      BuildContext context, ContactResponseModel contact) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: PrefManager.appScrollPhysics,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(contact.imgUrl),
            radius: SizeManager.s35,
          ),
          const SizedBox(
            width: SizeManager.s10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contact.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                contact.email,
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
      required List list,
      required List newList,
      required Stream<bool> stream,
      void Function()? onTap,
      String? trailingText,
      Color trailingColor = ColorManager.darkGrey,
      Color leadingColor = ColorManager.lightPrimary}) {
    return StreamBuilder<bool>(
        stream: stream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    ListTile(
                      onTap: onTap,
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: leadingColor,
                        child: Icon(
                          leadingIcon,
                          color: ColorManager.offWhite,
                        ),
                      ),
                      title: Text(title,
                          style: Theme.of(context).textTheme.bodyMedium),
                      trailing: snapshot.data!
                          ? null
                          : newList.isNotEmpty
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeManager.s8,
                                      vertical: SizeManager.s4),
                                  decoration: BoxDecoration(
                                    color: trailingColor,
                                    borderRadius:
                                        BorderRadius.circular(SizeManager.s16),
                                  ),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "${newList.length} $trailingText",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: ColorManager.white),
                                        ),
                                        const SizedBox(
                                          width: SizeManager.s5,
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
                    ),
                    if (snapshot.data!)
                      ListView.separated(
                          itemBuilder: (context, index) =>
                              newList[index].runtimeType == PaymentModelResponse
                                  ? ListTile(
                                      title: Text(
                                        "${newList[index].product.brand} ${newList[index].product.model}",
                                      ),
                                      trailing: Text(newList[index]
                                          .product
                                          .price
                                          .toString()),
                                    )
                                  : Text(newList[index].action),
                          physics: PrefManager.neverScrollPhysics,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: newList.length)
                  ],
                )
              : const SizedBox();
        });
  }
}
