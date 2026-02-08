import 'package:gaushala/models/animals_model.dart';
import 'package:stacked/stacked.dart';

import '../../../services/animal_service.dart';

class ListAnimalViewModel extends BaseViewModel {
  List<Animals> selectedAnimals = [];
  List<Animals> filterAnimals = [];

  bool isSelectionMode = false;

  Future<void> init() async {
    await fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    setBusy(true);
    filterAnimals = await AnimalService().fetchAnimals();
    setBusy(false);
  }

  void toggleSelection(Animals name) {
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
      await AnimalService().delete(name);
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
