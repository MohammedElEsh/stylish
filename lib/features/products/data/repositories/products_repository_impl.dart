import '../../../../core/errors/failures.dart';
import '../../../../core/errors/safe_call.dart';
import '../../../../core/networking/api_consumer.dart';
import '../../../../core/networking/api_endpoints.dart';
import '../models/product_model.dart';
import 'products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ApiConsumer _apiConsumer;

  ProductsRepositoryImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  EitherResult<List<ProductModel>> getProducts({
    required int offset,
    required int limit,
  }) {
    return safeCall(() async {
      final response = await _apiConsumer.get(
        ApiEndpoints.products,
        queryParameters: {'offset': offset, 'limit': limit},
      );

      if (response is! List) {
        throw const ServerFailure('Unexpected response format');
      }

      return response
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    });
  }
}