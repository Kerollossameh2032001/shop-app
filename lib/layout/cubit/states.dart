import 'package:shop_app/models/chanege_cart.dart';
import 'package:shop_app/models/change_favorites.dart';
import 'package:shop_app/models/login_model.dart';

abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

class LayoutChangeAngleState extends LayoutStates {}

class LayoutHomeDataLoadingState extends LayoutStates {}

class LayoutHomeDataSuccesState extends LayoutStates {}

class LayoutHomeDataErrorState extends LayoutStates {}

class LayoutCategoriesDataLoadingState extends LayoutStates {}

class LayoutCategoriesDataSuccesState extends LayoutStates {}

class LayoutCategoriesDataErrorState extends LayoutStates {}

class LayoutSearchDataLoadingState extends LayoutStates {}

class LayoutSearchDataSuccesState extends LayoutStates {}

class LayoutSearchDataErrorState extends LayoutStates {}

class LayoutChangeFavoritesLoadingState extends LayoutStates {}

class LayoutChangeFavoritesSuccesState extends LayoutStates {
  final ChangeFavoriteModel changeFavoriteModel;

  LayoutChangeFavoritesSuccesState(this.changeFavoriteModel);
}

class LayoutChangeFavoritesErrorState extends LayoutStates {}

class LayoutGetFavoritesDataLoadingState extends LayoutStates {}

class LayoutGetFavoritesDataSuccesState extends LayoutStates {}

class LayoutGetFavoritesDataErrorState extends LayoutStates {}

class LayoutProfileDataLoadingState extends LayoutStates {}

class LayoutProfileDataSuccesState extends LayoutStates {}

class LayoutProfileDataErrorState extends LayoutStates {}

class LayoutProfileChangeShowToEditState extends LayoutStates {}

class LayoutProfileChangeUpdateButtonState extends LayoutStates {}

class LayoutUpdateProfileDataLoadingState extends LayoutStates {}

class LayoutUpdateProfileDataSuccesState extends LayoutStates {
  final LoginModel profileData;

  LayoutUpdateProfileDataSuccesState(this.profileData);
}

class LayoutUpdateProfileDataErrorState extends LayoutStates {}


class LayoutChangeCartsLoadingState extends LayoutStates {}

class LayoutChangeCartsSuccesState extends LayoutStates {
  final ChangeCarts changeCartsModel;

  LayoutChangeCartsSuccesState(this.changeCartsModel);
}

class LayoutChangeCartsErrorState extends LayoutStates {}

class LayoutGetCartDataLoadingState extends LayoutStates {}
class LayoutGetCartDataSuccesState extends LayoutStates {}
class LayoutGetCartDataErrorState extends LayoutStates {}

