import 'package:dartz/dartz.dart';

import '../../../../../core/params/params.dart';
import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../entities/template_entity.dart';

abstract class TemplateRepository {
  Future<Either<Failure, TemplateEntity>> getTemplate({
    required TemplateParams templateParams,
  });
}
