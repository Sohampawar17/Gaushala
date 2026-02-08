import 'package:flutter/material.dart';
import 'package:gaushala/models/collection_model.dart';
import 'package:gaushala/models/purcahse_model.dart';
import 'package:gaushala/router.router.dart';
import 'package:gaushala/services/purchase_services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AddPurchaseViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final itemFormKey = GlobalKey<FormState>();

  Collection purchase = Collection();
  DateTime? selectedDOB;
  PurchaseMaster master = PurchaseMaster();
  final TextEditingController dobController = TextEditingController();
  bool isEdit = false;
  List<String> items = [];
  List<Items> selectedItems = [];
  List<String> uom = [];
  List<String> warehouse = [];
  List<PurchaseList> purchases = [];
  List<PurchaseList> selectPurchases = [];

  void init(String supplier, PurchaseMaster master) async {
    setBusy(true);
    master = master;
    items = master.item ?? [];
    warehouse = master.warehouse ?? [];
    uom = master.uom ?? [];
    purchases = master.purchaseList ?? [];
    purchases =
        purchases.where((element) => element.supplier == supplier).toList();
    selectPurchases.clear();
    purchase.supplier = supplier;
    // if (id.isNotEmpty) {
    //   animalData = await AnimalService().get(id) ?? Animals();
    //   isEdit = true;
    //   idController.text = animalData.animalId ?? "";
    //   dobController.text = animalData.dateOfBirth ?? "";
    // }
    setBusy(false);
  }

  bool isSelectionMode = false;

  void toggleSelection(PurchaseList collection) {
    if (selectPurchases.contains(collection)) {
      selectPurchases.remove(collection);
    } else {
      selectPurchases.add(collection);
    }
    isSelectionMode = selectPurchases.isNotEmpty;
    notifyListeners();
  }

  Future<void> deleteSelectedSuppliers(BuildContext context) async {
    if (selectPurchases.isEmpty) return;

    try {
      // Optionally show loading indicator here
      for (final collection in selectPurchases) {
        await PurchaseService().delete(collection);
      }
      selectPurchases.clear();
      isSelectionMode = false;
      Navigator.pushReplacementNamed(context, Routes.homePage);
    } catch (e) {
      // Optionally handle or log the error
      debugPrint("Error deleting suppliers: $e");
    }
  }

  void resetSelection() {
    isSelectionMode = false;
    selectPurchases.clear();
    notifyListeners();
  }

  bool isSelected(PurchaseList name) {
    return selectPurchases.contains(name);
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one item'),
          duration: Duration(seconds: 2), // optional
          behavior: SnackBarBehavior.floating, // optional for nicer look
        ),
      );
      return; // stop further execution if needed
    }
    if (formKey.currentState!.validate()) {
      purchase.customMobileEntry = 1;
      purchase.items = selectedItems;
      purchase.docstatus = 1;
      bool res = false;
      // if (isEdit == true) {
      //   res = await AnimalService().update(animalData);
      //   if (res) {
      //     if (context.mounted) {
      //       setBusy(false);
      //       Navigator.pop(context);
      //     }
      //   }
      // } else {
      res = await PurchaseService().create(purchase);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pushReplacementNamed(context, Routes.homePage);
        }
      }
      // }
    }
    setBusy(false);
  }

  Future<void> selectDOB(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDOB ?? DateTime.now(),
      firstDate: DateTime(2001),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDOB = picked;
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      purchase.postingDate = dobController.text;
      notifyListeners();
    }
  }

  void addItem(Items item) {
    item.amount = (item.qty ?? 1) * (item.rate ?? 0);
    print(item.amount);
    selectedItems.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < selectedItems.length) {
      selectedItems.removeAt(index);
      notifyListeners();
    }
  }

  // Helpers to update qty/rate for an existing item (updates amount too)
  void updateQty(int index, double qty) {
    selectedItems[index].qty = qty;
    notifyListeners();
  }

  void updateRate(int index, double rate) {
    selectedItems[index].rate = rate;
    notifyListeners();
  }
}
