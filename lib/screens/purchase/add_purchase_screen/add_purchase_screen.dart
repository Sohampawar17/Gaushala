import 'package:flutter/material.dart';
import 'package:gaushala/models/collection_model.dart';
import 'package:gaushala/models/purcahse_model.dart';
import 'package:gaushala/screens/purchase/add_purchase_screen/add_purchase_viewmodel.dart';
import 'package:gaushala/services/purchase_services.dart';
import 'package:stacked/stacked.dart';

class SelectSupplierScreen extends StatelessWidget {
  const SelectSupplierScreen({super.key});

  Future<PurchaseMaster> _fetchSuppliers() async {
    final service = PurchaseService();
    return await service.masters() ?? PurchaseMaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Supplier"),
      ),
      body: FutureBuilder<PurchaseMaster>(
        future: _fetchSuppliers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Failed to load suppliers."),
            );
          }

          final master = snapshot.data!;
          final suppliers = master.supplier ?? [];

          if (suppliers.isEmpty) {
            return const Center(
              child: Text("No suppliers found."),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: suppliers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              final theme = Theme.of(context);

              return Card(
                elevation: 3,
                color: theme.colorScheme.primary, // Yellowish from theme
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      supplier.name?.isNotEmpty == true
                          ? supplier.name![0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  title: Text(
                    supplier.name ?? "",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          theme.colorScheme.onPrimaryContainer, // Contrast text
                    ),
                  ),
                  subtitle: supplier.balance != null && supplier.balance != 0
                      ? Text(
                          supplier.balance.toString(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme
                                .onPrimaryContainer, // Contrast text
                          ),
                        )
                      : null,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PurchaseFormScreen(
                          selectedSupplier: supplier.name.toString(),
                          master: master,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PurchaseFormScreen extends StatefulWidget {
  final String selectedSupplier;
  final PurchaseMaster master;
  const PurchaseFormScreen(
      {super.key, required this.selectedSupplier, required this.master});

  @override
  State<PurchaseFormScreen> createState() => _PurchaseFormScreenState();
}

class _PurchaseFormScreenState extends State<PurchaseFormScreen> {
  void _addItem(Items item, AddPurchaseViewModel model) {
    final _qtyController = TextEditingController();
    final _rateController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (_, controller) => Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              controller: controller,
              child: Form(
                key: model.itemFormKey, // ✅ Your form key
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Add Item',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔹 Item dropdown
                    DropdownButtonFormField<String>(
                      value: item.itemCode,
                      isExpanded: true,
                      decoration: _inputDecoration('Item', Icons.shopping_cart),
                      hint: const Text('Select Item'),
                      items: model.items.map((itm) {
                        return DropdownMenuItem(
                          value: itm,
                          child: Text(itm),
                        );
                      }).toList(),
                      onChanged: (value) => item.itemCode = value,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please select an item'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Warehouse dropdown
                    DropdownButtonFormField<String>(
                      value: item.warehouse,
                      isExpanded: true,
                      decoration: _inputDecoration('Warehouse', Icons.store),
                      hint: const Text('Select Warehouse'),
                      items: model.warehouse.map((wh) {
                        return DropdownMenuItem(
                          value: wh,
                          child: Text(wh),
                        );
                      }).toList(),
                      onChanged: (value) => item.warehouse = value,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please select a warehouse'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // 🔹 UOM dropdown
                    DropdownButtonFormField<String>(
                      value: item.uom,
                      isExpanded: true,
                      decoration: _inputDecoration('UOM', Icons.straighten),
                      hint: const Text('Select UOM'),
                      items: model.uom.map((uom) {
                        return DropdownMenuItem(
                          value: uom,
                          child: Text(uom),
                        );
                      }).toList(),
                      onChanged: (value) => item.uom = value,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please select a UOM'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Quantity input
                    TextFormField(
                      controller: _qtyController,
                      decoration: _inputDecoration(
                          'Quantity', Icons.format_list_numbered),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter quantity';
                        }
                        final qty = double.tryParse(value);
                        if (qty == null || qty <= 0) {
                          return 'Quantity must be greater than 0';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Rate input
                    TextFormField(
                      controller: _rateController,
                      decoration:
                          _inputDecoration('Rate', Icons.currency_rupee),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter rate';
                        }
                        final rate = double.tryParse(value);
                        if (rate == null || rate < 0) {
                          return 'Rate must be a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // 🔹 Add Item Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (model.itemFormKey.currentState?.validate() ??
                              false) {
                            // ✅ Only proceed if form is valid
                            item.qty =
                                double.tryParse(_qtyController.text.trim()) ??
                                    0;
                            item.rate =
                                double.tryParse(_rateController.text.trim()) ??
                                    0;

                            model.addItem(item);
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Item'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPurchaseViewModel>.reactive(
        viewModelBuilder: () => AddPurchaseViewModel(),
        onViewModelReady: (model) {
          model.init(widget.selectedSupplier, widget.master);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Purchase Form"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: model.formKey,
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: const Text("Supplier"),
                        subtitle: Text(widget.selectedSupplier),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your date';
                        }
                        return null; // valid
                      },
                      controller: model.dobController,
                      onTap: () => model.selectDOB(context),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 16.0),
                        labelText: 'Posting Date',
                        hintText: 'Posting Date',
                        prefixIcon: const Icon(Icons.calendar_today_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: model.selectedItems.length,
                      itemBuilder: (context, index) {
                        final item = model.selectedItems[index];

                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          // margin: const EdgeInsets.symmetric(
                          //     vertical: 8, horizontal: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top row: Item Name + Delete
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.itemCode ?? "",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      onPressed: () {
                                        model.removeItem(index);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // Rate, Qty, Amount vertically stacked
                                Column(
                                  children: [
                                    _buildInfoRow("Rate",
                                        "₹${item.rate?.toStringAsFixed(2)}"),
                                    const SizedBox(height: 4),
                                    _buildInfoRow(
                                        "Qty", "${item.qty} ${item.uom}"),
                                    const SizedBox(height: 4),
                                    _buildInfoRow("Amount",
                                        "₹${item.amount?.toStringAsFixed(2)}"),
                                  ],
                                ),

                                const Divider(height: 16),

                                // Warehouse row
                                Row(
                                  children: [
                                    const Icon(Icons.warehouse_outlined,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        item.warehouse ?? "",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Text(
                    //   'Total Amount: ₹${_items.fold<double>(0, (sum, item) => sum + (double.tryParse(item['amountController'].text) ?? 0)).toStringAsFixed(2)}',
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    ElevatedButton.icon(
                      onPressed: () => _addItem(Items(), model),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Another Item'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // Your items, UOM, Warehouse etc here
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () => model.onSavePressed(context),
                      child: const Text("Save Purchase"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8.0),
                      itemCount: model.purchases.length,
                      itemBuilder: (context, index) {
                        final purchase = model.purchases[index];
                        final isSelected =
                            model.selectPurchases.contains(purchase);

                        return GestureDetector(
                          onTap: () {
                            if (model.selectPurchases.isNotEmpty) {
                              model.toggleSelection(purchase);
                            } else {
                              // 👉 Show dialog with purchase items
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  title: Text(
                                    "Sale: ${purchase.name}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          purchase.purchaseItems?.length ?? 0,
                                      itemBuilder: (context, i) {
                                        final item = purchase.purchaseItems![i];
                                        return Card(
                                          elevation: 2,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.itemName ?? "",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.blueAccent,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                    "Rate: ₹${item.rate?.toStringAsFixed(2)}"),
                                                Text(
                                                    "Qty: ${item.qty} ${item.uom}"),
                                                Text(
                                                    "Amount: ₹${item.amount?.toStringAsFixed(2)}"),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text("Close"),
                                    )
                                  ],
                                ),
                              );
                            }
                          },
                          onLongPress: () => model.toggleSelection(purchase),
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Colors.white.withOpacity(0.95),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: isSelected
                                    ? LinearGradient(
                                        colors: [
                                          Colors.blue[50]!,
                                          Colors.blue[100]!.withOpacity(0.3),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                border: Border(
                                  left: BorderSide(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey[300]!,
                                    width: 5,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Line 1: Purchase name
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        purchase.name ?? "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.5),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  // Line 2: Posting date + Qty
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("🧾 ${purchase.postingDate}",
                                          style:
                                              const TextStyle(fontSize: 13.5)),
                                      Text("📦 Qty: ${purchase.totalQty}",
                                          style:
                                              const TextStyle(fontSize: 13.5)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: model.selectPurchases.isNotEmpty
                ? FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    icon: const Icon(Icons.delete),
                    label: Text(
                      'Delete (${model.selectPurchases.length})',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Delete Selected"),
                          content: Text(
                              "Are you sure you want to delete ${model.selectPurchases.length} items?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );

                      if (confirmed == true) {
                        model.deleteSelectedSuppliers(context);
                      }
                    },
                  )
                : null,
          );
        });
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
