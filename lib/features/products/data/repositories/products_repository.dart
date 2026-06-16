import '../../../../core/errors/safe_call.dart';
import '../models/product_model.dart';

abstract class ProductsRepository {
  EitherResult<List<ProductModel>> getProducts({
    required int offset,
    required int limit,
  });
}
