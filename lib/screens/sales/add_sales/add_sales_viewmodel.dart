import 'package:flutter/material.dart';
import 'package:gaushala/models/sales_master.dart';
import 'package:gaushala/models/sales_model.dart';
import 'package:gaushala/router.router.dart';
import 'package:gaushala/services/sales_service.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AddSalesViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final itemFormKey = GlobalKey<FormState>();

  Sale sales = Sale();
  DateTime? selectedDOB;
  SalesMaster master = SalesMaster();
  final TextEditingController dobController = TextEditingController();
  bool isEdit = false;
  List<String> items = [];
  List<Items> selectedItems = [];
  List<String> uom = [];
  List<String> warehouse = [];
  List<CustomerList> purchases = [];
  List<CustomerList> selectPurchases = [];
  List<String> shift = ["", "Morning", "Evening"];
  bool isSelectionMode = false;

  void toggleSelection(CustomerList collection) {
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
        await SalesService().delete(collection);
      }
      selectPurchases.clear();
      isSelectionMode = false;
      Navigator.pushReplacementNamed(context, Routes.selectCustomerScreen);
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

  bool isSelected(CustomerList name) {
    return selectPurchases.contains(name);
  }

  void init(String supplier, SalesMaster master) async {
    setBusy(true);
    master = master;
    items = master.item ?? [];
    warehouse = master.warehouse ?? [];
    uom = master.uom ?? [];
    sales.customer = supplier;
    purchases = master.customerList ?? [];
    purchases =
        purchases.where((element) => element.customer == supplier).toList();
    // if (id.isNotEmpty) {
    //   animalData = await AnimalService().get(id) ?? Animals();
    //   isEdit = true;
    //   idController.text = animalData.animalId ?? "";
    //   dobController.text = animalData.dateOfBirth ?? "";
    // }
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);

    if (formKey.currentState!.validate()) {
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
      sales.customMobileEntry = 1;
      sales.items = selectedItems ?? [];
      sales.docstatus = 1;
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
      res = await SalesService().create(sales);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pushReplacementNamed(context, Routes.selectCustomerScreen);
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
      sales.postingDate = dobController.text;
      notifyListeners();
    }
  }

  void addItem(Items item) {
    item.amount = (item.qty ?? 0) * (item.rate ?? 0);
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

  Future<void> setShift(String? shift) async {
    sales.customShift = shift;
    notifyListeners();
  }

  void updateRate(int index, double rate) {
    selectedItems[index].rate = rate;
    notifyListeners();
  }
}
