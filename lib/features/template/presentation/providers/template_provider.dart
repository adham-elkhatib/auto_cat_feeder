import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/params/params.dart';
import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../../data/datasources/template_local_data_source.dart';
import '../../data/datasources/template_remote_data_source.dart';
import '../../data/repositories/template_repository_impl.dart';
import '../../domain/entities/template_entity.dart';
import '../../domain/usecases/get_template.dart';

class TemplateProvider extends ChangeNotifier {
  TemplateEntity? template;
  Failure? failure;

  TemplateProvider({
    this.template,
    this.failure,
  });

  void eitherFailureOrTemplate() async {
    TemplateRepositoryImpl repository = TemplateRepositoryImpl(
      remoteDataSource: TemplateRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrTemplate =
        await GetTemplate(templateRepository: repository).call(
      templateParams: TemplateParams(),
    );

    failureOrTemplate.fold(
      (Failure newFailure) {
        template = null;
        failure = newFailure;
        notifyListeners();
      },
      (TemplateEntity newTemplate) {
        template = newTemplate;
        failure = null;
        notifyListeners();
      },
    );
  }
}
