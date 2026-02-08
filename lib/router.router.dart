// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i13;
import 'package:flutter/material.dart';
import 'package:gaushala/models/collection_model.dart' as _i14;
import 'package:gaushala/screens/collections/collection_screen/add_collection_screen.dart'
    as _i8;
import 'package:gaushala/screens/collections/items/collection_items.dart'
    as _i7;
import 'package:gaushala/screens/collections/list_collections/list_collection_screeen.dart'
    as _i9;
import 'package:gaushala/screens/home_screen/home_page.dart' as _i3;
import 'package:gaushala/screens/login/login_view.dart' as _i4;
import 'package:gaushala/screens/masters/add_cow_masters/add_cow_screen.dart'
    as _i5;
import 'package:gaushala/screens/masters/list_animals/list_animals_screen.dart'
    as _i6;
import 'package:gaushala/screens/Material%20Transfer/add_material_transfer/add_material_transfer_screen.dart'
    as _i12;
import 'package:gaushala/screens/purchase/add_purchase_screen/add_purchase_screen.dart'
    as _i10;
import 'package:gaushala/screens/sales/add_sales/add_sales_screen.dart' as _i11;
import 'package:gaushala/screens/splash_screen/splash_screen.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i15;

class Routes {
  static const splashScreen = '/';

  static const homePage = '/home-page';

  static const loginViewScreen = '/login-view-screen';

  static const addAnimal = '/add-animal';

  static const listAnimalScreen = '/list-animal-screen';

  static const collectionsItems = '/collections-items';

  static const addCollections = '/add-collections';

  static const listCollectionScreen = '/list-collection-screen';

  static const selectSupplierScreen = '/select-supplier-screen';

  static const selectCustomerScreen = '/select-customer-screen';

  static const selectMaterialScreen = '/select-material-screen';

  static const all = <String>{
    splashScreen,
    homePage,
    loginViewScreen,
    addAnimal,
    listAnimalScreen,
    collectionsItems,
    addCollections,
    listCollectionScreen,
    selectSupplierScreen,
    selectCustomerScreen,
    selectMaterialScreen,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashScreen,
      page: _i2.SplashScreen,
    ),
    _i1.RouteDef(
      Routes.homePage,
      page: _i3.HomePage,
    ),
    _i1.RouteDef(
      Routes.loginViewScreen,
      page: _i4.LoginViewScreen,
    ),
    _i1.RouteDef(
      Routes.addAnimal,
      page: _i5.AddAnimal,
    ),
    _i1.RouteDef(
      Routes.listAnimalScreen,
      page: _i6.ListAnimalScreen,
    ),
    _i1.RouteDef(
      Routes.collectionsItems,
      page: _i7.CollectionsItems,
    ),
    _i1.RouteDef(
      Routes.addCollections,
      page: _i8.AddCollections,
    ),
    _i1.RouteDef(
      Routes.listCollectionScreen,
      page: _i9.ListCollectionScreen,
    ),
    _i1.RouteDef(
      Routes.selectSupplierScreen,
      page: _i10.SelectSupplierScreen,
    ),
    _i1.RouteDef(
      Routes.selectCustomerScreen,
      page: _i11.SelectCustomerScreen,
    ),
    _i1.RouteDef(
      Routes.selectMaterialScreen,
      page: _i12.SelectMaterialScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreen: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashScreen(),
        settings: data,
      );
    },
    _i3.HomePage: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.HomePage(),
        settings: data,
      );
    },
    _i4.LoginViewScreen: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginViewScreen(),
        settings: data,
      );
    },
    _i5.AddAnimal: (data) {
      final args = data.getArgs<AddAnimalArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.AddAnimal(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i6.ListAnimalScreen: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ListAnimalScreen(),
        settings: data,
      );
    },
    _i7.CollectionsItems: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.CollectionsItems(),
        settings: data,
      );
    },
    _i8.AddCollections: (data) {
      final args = data.getArgs<AddCollectionsArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.AddCollections(key: args.key, item: args.item),
        settings: data,
      );
    },
    _i9.ListCollectionScreen: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ListCollectionScreen(),
        settings: data,
      );
    },
    _i10.SelectSupplierScreen: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.SelectSupplierScreen(),
        settings: data,
      );
    },
    _i11.SelectCustomerScreen: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.SelectCustomerScreen(),
        settings: data,
      );
    },
    _i12.SelectMaterialScreen: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.SelectMaterialScreen(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AddAnimalArguments {
  const AddAnimalArguments({
    this.key,
    required this.id,
  });

  final _i13.Key? key;

  final String id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }

  @override
  bool operator ==(covariant AddAnimalArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

class AddCollectionsArguments {
  const AddCollectionsArguments({
    this.key,
    required this.item,
  });

  final _i13.Key? key;

  final _i14.Items item;

  @override
  String toString() {
    return '{"key": "$key", "item": "$item"}';
  }

  @override
  bool operator ==(covariant AddCollectionsArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.item == item;
  }

  @override
  int get hashCode {
    return key.hashCode ^ item.hashCode;
  }
}

extension NavigatorStateExtension on _i15.NavigationService {
  Future<dynamic> navigateToSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddAnimal({
    _i13.Key? key,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addAnimal,
        arguments: AddAnimalArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListAnimalScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listAnimalScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCollectionsItems([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.collectionsItems,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddCollections({
    _i13.Key? key,
    required _i14.Items item,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addCollections,
        arguments: AddCollectionsArguments(key: key, item: item),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListCollectionScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listCollectionScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSelectSupplierScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.selectSupplierScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSelectCustomerScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.selectCustomerScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSelectMaterialScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.selectMaterialScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddAnimal({
    _i13.Key? key,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addAnimal,
        arguments: AddAnimalArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListAnimalScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listAnimalScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCollectionsItems([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.collectionsItems,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddCollections({
    _i13.Key? key,
    required _i14.Items item,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addCollections,
        arguments: AddCollectionsArguments(key: key, item: item),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListCollectionScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listCollectionScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSelectSupplierScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.selectSupplierScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSelectCustomerScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.selectCustomerScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSelectMaterialScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.selectMaterialScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
