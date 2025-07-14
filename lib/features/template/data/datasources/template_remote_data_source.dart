import 'package:dio/dio.dart';

import '../../../../../core/params/params.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../models/template_model.dart';

abstract class TemplateRemoteDataSource {
  Future<TemplateModel> getTemplate({required TemplateParams templateParams});
}

class TemplateRemoteDataSourceImpl implements TemplateRemoteDataSource {
  final Dio dio;

  TemplateRemoteDataSourceImpl({required this.dio});

  @override
  Future<TemplateModel> getTemplate(
      {required TemplateParams templateParams}) async {
    final response = await dio.get(
      'URL',
      queryParameters: {
        'api_key': 'optional',
      },
    );

    if (response.statusCode == 200) {
      return TemplateModel.fromJson(json: response.data);
    } else {
      throw ServerException(message: '');
    }
  }
}
