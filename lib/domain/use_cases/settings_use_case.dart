import 'package:sneakers_shop/data/network/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sneakers_shop/data/network/repository/repository.dart';
import 'package:sneakers_shop/domain/model/settings_model.dart';

import 'base_use_case.dart';

class SettingsUseCase extends BaseUseCase<void, SettingsModel> {
  final Repository _repository;
  SettingsUseCase(this._repository);
  @override
  Future<Either<Failure, SettingsModel>> execute(void input) {
    return _repository.getSettings();
  }
}
