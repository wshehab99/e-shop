import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../resources/asset_manager.dart';
import '../../resources/color_manger.dart';
import '../../resources/size_manager.dart';
import '../../resources/string_manager.dart';
import 'state_renderer.dart';

class StateRenderer extends StatelessWidget {
  const StateRenderer({
    super.key,
    required this.stateRendererType,
    required this.message,
    this.retryFunction,
  });
  final StateRendererType stateRendererType;
  final String message;
  final Function? retryFunction;
  @override
  Widget build(BuildContext context) {
    return _getStateRendererWidget(stateRendererType, context, message);
  }

  Widget _getStateRendererWidget(StateRendererType stateRendererType,
      BuildContext context, String message) {
    switch (stateRendererType) {
      case StateRendererType.loadingPopupState:
        return _getPopupDialog(context: context, children: [
          _getAnimatedImage(
            AssetJsonManager.loading,
          ),
          _getMessage(message, context),
        ]);
      case StateRendererType.errorPopupState:
        return _getPopupDialog(context: context, children: [
          _getAnimatedImage(
            AssetJsonManager.error,
          ),
          _getMessage(message, context),
          _getRetryButton(context, StringManager.cancel),
        ]);
      case StateRendererType.successPopupState:
        return _getPopupDialog(context: context, children: [
          _getAnimatedImage(
            AssetJsonManager.success,
          ),
          _getMessage(message, context),
        ]);
      case StateRendererType.loadingFullScreenState:
        return _getItemColumn(children: [
          _getAnimatedImage(
            AssetJsonManager.loading,
          ),
          _getMessage(message, context),
        ]);
      case StateRendererType.errorFullScreenState:
        return _getItemColumn(children: [
          _getAnimatedImage(
            AssetJsonManager.error,
          ),
          _getMessage(message, context),
          //_getRetryButton(context, StringManager.retryAgain),
        ]);
      case StateRendererType.emptyState:
        return _getItemColumn(children: [
          _getAnimatedImage(
            AssetJsonManager.empty,
          ),
          _getMessage(message, context),
        ]);
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getItemColumn(
      {required List<Widget> children,
      MainAxisSize mainAxisSize = MainAxisSize.max}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  Widget _getPopupDialog(
      {required BuildContext context, required List<Widget> children}) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(
            SizeManager.s14,
          ),
          boxShadow: const [
            BoxShadow(
              color: ColorManager.black,
            ),
          ],
        ),
        child: _getDialogContent(context: context, children: children),
      ),
    );
  }

  Widget _getDialogContent(
      {required BuildContext context, required List<Widget> children}) {
    return _getItemColumn(children: children, mainAxisSize: MainAxisSize.min);
  }

  Widget _getAnimatedImage(String jsonName) {
    return Lottie.asset(
      jsonName,
      height: SizeManager.s100,
      width: SizeManager.s100,
    );
  }

  Widget _getMessage(message, context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium,
    ).tr();
  }

  Widget _getRetryButton(context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SizeManager.s28, vertical: SizeManager.s14),
      child: SizedBox(
          width: double.infinity,
          height: SizeManager.s40,
          child: ElevatedButton(
              onPressed:
                  stateRendererType == StateRendererType.errorFullScreenState
                      ? retryFunction!.call()
                      : () {
                          Navigator.pop(context);
                        },
              child: Text(text).tr())),
    );
  }
}
