import 'package:flutter/material.dart';
import 'package:gaushala/models/material_master.dart';
import 'package:gaushala/models/material_transfer.dart';
import 'package:gaushala/router.router.dart';
import 'package:gaushala/services/material_transfer_service.dart';
import 'package:stacked/stacked.dart';

class AddMaterialViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  final TextEditingController dobController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  Items item = Items();
  MaterialTransfer material = MaterialTransfer();
  List<StockList> stocks = [];
  List<StockList> selectedStocks = [];

  List<String> warehouse = [];

  bool isSelectionMode = false;

  void toggleSelection(StockList collection) {
    if (selectedStocks.contains(collection)) {
      selectedStocks.remove(collection);
    } else {
      selectedStocks.add(collection);
    }
    isSelectionMode = selectedStocks.isNotEmpty;
    notifyListeners();
  }

  Future<void> deleteSelectedSuppliers(BuildContext context) async {
    if (selectedStocks.isEmpty) return;

    try {
      // Optionally show loading indicator here
      for (final collection in selectedStocks) {
        await StockService().delete(collection);
      }
      selectedStocks.clear();
      isSelectionMode = false;
      Navigator.pushReplacementNamed(context, Routes.selectMaterialScreen);
    } catch (e) {
      // Optionally handle or log the error
      debugPrint("Error deleting suppliers: $e");
    }
  }

  void resetSelection() {
    isSelectionMode = false;
    selectedStocks.clear();
    notifyListeners();
  }

  bool isSelected(MaterialTransfer name) {
    return selectedStocks.contains(name);
  }

  void init(Items selectItem, MaterialTransferMaster master) async {
    setBusy(true);
    stocks = master.stockList ?? [];
    warehouse = master.warehouse ?? [];
    item = selectItem;
    item.allowZeroValuationRate = 1;
    setBusy(false);
  }

  Future<void> onSavePressed(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    material
      ..customMobileAppEntry = 1
      ..items ??= []
      ..items!.add(item)
      ..stockEntryType = "Material Transfer"
      ..docstatus = 1;

    setBusy(true);
    try {
      final res = await StockService().create(material);
      if (res && context.mounted) {
        Navigator.pushReplacementNamed(context, Routes.selectMaterialScreen);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to save. Please try again.")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      setBusy(false);
    }
  }

  void setQty(String? qty) {
    qtyController.text = qty ?? "0.0";
    item.qty = double.tryParse(qtyController.text);
    notifyListeners();
  }

  void sWarehouse(String? sWarehouse) {
    item.sWarehouse = sWarehouse;
    notifyListeners();
  }

  void tWarehouse(String? tWarehouse) {
    item.tWarehouse = tWarehouse;
    notifyListeners();
  }
}
