import 'package:gaushala/models/animals_model.dart';
import 'package:stacked/stacked.dart';

import '../../../models/list_collection.dart';
import '../../../services/collections_services.dart';

class ListCollectionViewModel extends BaseViewModel {
  List<ListCollection> selectedAnimals = [];
  List<ListCollection> filterAnimals = [];
  bool isSelectionMode = false;

  Future<void> init() async {
    await fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    setBusy(true);
    // filterAnimals = await CollectionService().fetchCollections();
    setBusy(false);
  }

  void toggleSelection(ListCollection name) {
    if (selectedAnimals.contains(name)) {
      selectedAnimals.remove(name);
      if (selectedAnimals.isEmpty) isSelectionMode = false;
    } else {
      selectedAnimals.add(name);
      isSelectionMode = true;
    }
    notifyListeners();
  }

  Future<void> deleteSelectedSuppliers() async {
    for (final name in selectedAnimals) {
      await CollectionService().delete(name);
    }

    selectedAnimals.clear();
    isSelectionMode = false;
    await fetchSuppliers();
  }

  void resetSelection() {
    isSelectionMode = false;
    selectedAnimals.clear();
    notifyListeners();
  }

  bool isSelected(Animals name) {
    return selectedAnimals.contains(name);
  }
}
