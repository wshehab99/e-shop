import 'package:flutter/material.dart';

import 'state_renderer_implementer.dart';

abstract class FlowState {
  StateRendererType getStateType();
  String getMessage();
}

class LoadingState implements FlowState {
  final StateRendererType type;
  final String message;
  LoadingState({required this.type, required this.message});
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateType() => type;
}

class ErrorState implements FlowState {
  final StateRendererType type;
  final String message;
  ErrorState({required this.type, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateType() => type;
}

class SuccessState implements FlowState {
  final StateRendererType type;
  final String message;
  SuccessState({required this.type, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateType() => type;
}

class EmptyState implements FlowState {
  final StateRendererType type;
  final String message;
  EmptyState({required this.type, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateType() => type;
}

class ContentState implements FlowState {
  final StateRendererType type;
  final String message;
  ContentState({required this.type, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateType() => type;
}

enum StateRendererType {
  loadingPopupState,
  errorPopupState,
  successPopupState,

  loadingFullScreenState,
  errorFullScreenState,
  successFullScreenState,

  emptyState,
  contentState,
}

extension FlowStateExtension on FlowState {
  Widget renderWidget(BuildContext context, Widget contentScreenWidget,
      {Function? retryFunction}) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateType() == StateRendererType.loadingPopupState) {
          showPopup(context, getStateType(), getMessage(),
              retryFunction: retryFunction);
          return contentScreenWidget;
        } else {
          return StateRenderer(
            message: getMessage(),
            stateRendererType: getStateType(),
            retryFunction: retryFunction,
          );
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateType() == StateRendererType.errorPopupState) {
          showPopup(context, getStateType(), getMessage(),
              retryFunction: retryFunction);
          return contentScreenWidget;
        } else {
          return StateRenderer(
            message: getMessage(),
            stateRendererType: getStateType(),
            retryFunction: retryFunction,
          );
        }
      case SuccessState:
        dismissDialog(context);
        if (getStateType() == StateRendererType.successPopupState) {
          showPopup(context, getStateType(), getMessage(),
              retryFunction: retryFunction);
          return contentScreenWidget;
        } else {
          return StateRenderer(
            message: getMessage(),
            stateRendererType: getStateType(),
            retryFunction: retryFunction,
          );
        }
      case EmptyState:
        dismissDialog(context);
        return StateRenderer(
            message: getMessage(), stateRendererType: getStateType());
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;

      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }
}

bool _isCurrentDialog(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

dismissDialog(BuildContext context) {
  if (_isCurrentDialog(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

showPopup(
    BuildContext context, StateRendererType stateRendererType, String message,
    {Function? retryFunction}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              retryFunction: retryFunction,
            ));
  });
}
