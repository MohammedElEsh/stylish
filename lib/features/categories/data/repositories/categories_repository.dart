import '../../../../core/errors/safe_call.dart';
import '../models/category_model.dart';

abstract class CategoriesRepository {
  EitherResult<List<CategoryModel>> getCategories();
}
