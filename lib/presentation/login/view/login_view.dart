import 'package:flutter/material.dart';
import 'package:sneakers_shop/app/dependency_injection.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/login/view_model/login_view_model.dart';
import 'package:sneakers_shop/presentation/resources/asset_manager.dart';
import 'package:sneakers_shop/presentation/resources/color_manger.dart';
import 'package:sneakers_shop/presentation/resources/pref_manager.dart';
import 'package:sneakers_shop/presentation/resources/route_manger.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final LoginViewModel _viewModel =
      DependencyInjection.instance<LoginViewModel>();
  void _bind() {
    _usernameController.addListener(() {
      _viewModel.setUsername(_usernameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
  }

  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.renderWidget(context, _getWidget()) ??
                _getWidget();
          }),
    );
  }

  Widget _getWidget() {
    return SingleChildScrollView(
      physics: PrefManager.appScrollPhysics,
      child: Padding(
        padding: const EdgeInsets.all(SizeManager.s10),
        child: _getForm(),
      ),
    );
  }

  Widget _getForm() {
    return Form(
      child: Column(
        children: [
          Image.asset(AssetImageManager.splash),
          const SizedBox(
            height: SizeManager.s18,
          ),
          StreamBuilder<bool>(
              stream: _viewModel.outputUsernameValid,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: StringManager.username,
                      labelText: StringManager.username,
                      errorText: (snapshot.data ?? true)
                          ? null
                          : StringManager.usernameError),
                );
              }),
          const SizedBox(
            height: SizeManager.s14,
          ),
          StreamBuilder<bool>(
              stream: _viewModel.outputPasswordValid,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: StringManager.password,
                      labelText: StringManager.password,
                      errorText: snapshot.data ?? true
                          ? null
                          : StringManager.passwordError),
                );
              }),
          const SizedBox(
            height: SizeManager.s18,
          ),
          SizedBox(
            width: double.infinity,
            child: StreamBuilder<bool>(
                stream: _viewModel.outputAllFieldsValid,
                builder: (context, snapshot) {
                  return ElevatedButton(
                      onPressed:
                          snapshot.data ?? false ? _viewModel.login : null,
                      child: const Text(StringManager.login));
                }),
          ),
          const SizedBox(
            height: SizeManager.s8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteManager.forgetPassword);
                },
                style: Theme.of(context).textButtonTheme.style!.copyWith(
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero))),
                child: Text(
                  StringManager.forgetPassword,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: ColorManager.primary),
                ),
              ),
              Row(
                children: [
                  Text(StringManager.notMember,
                      style: Theme.of(context).textTheme.bodySmall),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteManager.register);
                    },
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero))),
                    child: const Text(
                      StringManager.register,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
