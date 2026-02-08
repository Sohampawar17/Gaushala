import 'package:flutter/material.dart';
import 'package:gaushala/models/animals_model.dart';
import 'package:gaushala/models/collection_model.dart';
import 'package:gaushala/models/list_collection.dart';
import 'package:gaushala/router.router.dart';
import 'package:gaushala/services/collections_services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class AddCollectionViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  Collection collectionData = Collection();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  Items item = Items();

  List<ListCollection> selectedAnimals = [];
  List<ListCollection> filterAnimals = [];
  List<ListCollection> allCollections = []; // NEW: store all fetched data
  bool isSelectionMode = false;

  void toggleSelection(ListCollection collection) {
    if (selectedAnimals.contains(collection)) {
      selectedAnimals.remove(collection);
    } else {
      selectedAnimals.add(collection);
    }
    isSelectionMode = selectedAnimals.isNotEmpty;
    notifyListeners();
  }

  Future<void> deleteSelectedSuppliers() async {
    if (selectedAnimals.isEmpty) return;

    try {
      // Optionally show loading indicator here
      for (final collection in selectedAnimals) {
        await CollectionService().delete(collection);
      }
      selectedAnimals.clear();
      isSelectionMode = false;
      await fetchCollections();
    } catch (e) {
      // Optionally handle or log the error
      debugPrint("Error deleting suppliers: $e");
    }
  }

  Future<void> fetchCollections() async {
    filterAnimals = await CollectionService().fetchCollections(
        item.itemCode ?? "",
        collectionData.customShift ?? "",
        dobController.text);
    notifyListeners();

    /// Apply filters on fresh data
  }

  void resetSelection() {
    isSelectionMode = false;
    selectedAnimals.clear();
    notifyListeners();
  }

  bool isSelected(Animals name) {
    return selectedAnimals.contains(name);
  }

  List<String> shift = ["", "Morning", "Evening"];

  void init(Items selectItem) async {
    setBusy(true);

    dobController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    item = selectItem;

    await fetchCollections();
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    collectionData.customMobileEntry = 1;

    collectionData.items ??= [];
    collectionData.items!.add(item);
    collectionData.docstatus = 1;
    Logger().i(collectionData.toJson());

    setBusy(true);
    if (formKey.currentState!.validate()) {
      final res = await CollectionService().create(collectionData);
      if (res && context.mounted) {
        setBusy(false);
        Navigator.popAndPushNamed(context, Routes.collectionsItems);
      }
    }
    setBusy(false);
  }

  Future<void> selectDOB(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2001),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate = picked;
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      collectionData.postingDate = dobController.text;
      await fetchCollections();
      notifyListeners();
    }
  }

  Future<void> setShift(String? shift) async {
    collectionData.customShift = shift;
    await fetchCollections();
    notifyListeners();
  }

  void setQty(String? qty) {
    qtyController.text = qty ?? "0.0";
    item.qty = double.tryParse(qtyController.text);
    notifyListeners();
  }
}
