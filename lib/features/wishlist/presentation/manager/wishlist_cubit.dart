import 'package:flutter_bloc/flutter_bloc.dart';

import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistInitial());

  Future<void> load() async {
    emit(const WishlistInitial());
    emit(const WishlistLoading());
  }
}
