import 'package:gaushala/screens/Material%20Transfer/add_material_transfer/add_material_transfer_screen.dart';
import 'package:gaushala/screens/purchase/add_purchase_screen/add_purchase_screen.dart';
import 'package:gaushala/screens/sales/add_sales/add_sales_screen.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'screens/collections/collection_screen/add_collection_screen.dart';
import 'screens/collections/items/collection_items.dart';
import 'screens/collections/list_collections/list_collection_screeen.dart';
import 'screens/home_screen/home_page.dart';
import 'screens/login/login_view.dart';
import 'screens/masters/add_cow_masters/add_cow_screen.dart';
import 'screens/masters/list_animals/list_animals_screen.dart';
import 'screens/splash_screen/splash_screen.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: HomePage),
    MaterialRoute(page: LoginViewScreen),
    MaterialRoute(page: AddAnimal),
    MaterialRoute(page: ListAnimalScreen),
    MaterialRoute(page: CollectionsItems),
    MaterialRoute(page: AddCollections),
    MaterialRoute(page: ListCollectionScreen),
    MaterialRoute(page: SelectSupplierScreen),
    MaterialRoute(page: SelectCustomerScreen),
    MaterialRoute(page: SelectMaterialScreen)
  ],
  dependencies: [
    Singleton(classType: NavigationService),
  ],
)
class App {
  //empty class, will be filled after code generation
}
// flutter pub run build_runner build --delete-conflicting-outputs
