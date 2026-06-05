import '../../../../core/errors/failures.dart';
import '../../../../core/errors/safe_call.dart';
import '../../../../core/networking/api_consumer.dart';
import '../../../../core/networking/api_endpoints.dart';
import '../models/category_model.dart';
import 'categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final ApiConsumer _apiConsumer;

  CategoriesRepositoryImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  EitherResult<List<CategoryModel>> getCategories() {
    return safeCall(() async {
      final response = await _apiConsumer.get(ApiEndpoints.categories);

      if (response is! List) {
        throw const ServerFailure('Unexpected response format');
      }

      return response
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    });
  }
}
