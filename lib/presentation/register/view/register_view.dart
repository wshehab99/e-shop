import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../app/dependency_injection.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../resources/asset_manager.dart';
import '../../resources/route_manger.dart';
import '../../resources/size_manager.dart';
import '../../resources/string_manager.dart';
import '../view_model.dart/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel =
      DependencyInjection.instance<RegisterViewModel>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  void _bind() {
    _usernameController.addListener(() {
      _viewModel.setUsername(_usernameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _nameController.addListener(() {
      _viewModel.setName(_nameController.text);
    });
    _viewModel.isRegistered.stream.listen((isRegistered) {
      if (isRegistered) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(RouteManager.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _viewModel.init();
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
            return snapshot.data?.renderWidget(context, _getContent()) ??
                _getContent();
          }),
    );
  }

  Widget _getContent() {
    return SingleChildScrollView(
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
              stream: _viewModel.outputNameValid,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: StringManager.name,
                      labelText: StringManager.name,
                      errorText: (snapshot.data ?? true)
                          ? null
                          : StringManager.nameError),
                );
              }),
          const SizedBox(
            height: SizeManager.s14,
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
                          snapshot.data ?? false ? _viewModel.register : null,
                      child: const Text(StringManager.register).tr());
                }),
          ),
          const SizedBox(
            height: SizeManager.s8,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(StringManager.alreadyMember,
                    style: Theme.of(context).textTheme.bodySmall).tr(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: Theme.of(context).textButtonTheme.style!.copyWith(
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero))),
                  child: const Text(
                    StringManager.login,
                  ).tr(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
