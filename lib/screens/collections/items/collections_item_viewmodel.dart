import 'package:gaushala/models/collection_model.dart';
import 'package:stacked/stacked.dart';

import '../../../services/collections_services.dart';

class CollectionItemsViewModel extends BaseViewModel {
  List<Items> items = [];
  void init() async {
    setBusy(true);
    items = (await CollectionService().fetchItems()).cast<Items>();
    print(items);
    setBusy(false);
  }
}
