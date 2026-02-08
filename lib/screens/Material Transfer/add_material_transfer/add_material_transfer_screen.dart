import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaushala/constants.dart';
import 'package:gaushala/models/material_master.dart';
import 'package:gaushala/models/material_transfer.dart';
import 'package:gaushala/screens/Material%20Transfer/add_material_transfer/add_material_transfer_viewmodel.dart';
import 'package:gaushala/services/material_transfer_service.dart';
import 'package:gaushala/widgets/customtextfield.dart';
import 'package:gaushala/widgets/drop_down.dart';
import 'package:stacked/stacked.dart';

class SelectMaterialScreen extends StatelessWidget {
  const SelectMaterialScreen({super.key});

  Future<MaterialTransferMaster> _fetchSuppliers() async {
    final service = StockService();
    return await service.masters() ?? MaterialTransferMaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select Item"),
        ),
        body: FutureBuilder<MaterialTransferMaster>(
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
              List<Items> suppliers = master.item ?? [];

              if (suppliers.isEmpty) {
                return const Center(
                  child: Text("No item found."),
                );
              }

              return GridView.builder(
                itemCount: suppliers.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final supplier = suppliers[index];
                  return SupplierCard(
                    item: supplier,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MaterialFormScreen(
                            selectedSupplier: supplier,
                            master: master,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }));
  }
}

class SupplierCard extends StatelessWidget {
  final dynamic item; // replace with your Supplier model
  final VoidCallback onTap;

  const SupplierCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.image != null && item.image!.isNotEmpty
        ? "$baseurl${item.image}"
        : 'http://schoolssportswear.com/img/nopdt.jpg';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image on top
              AspectRatio(
                aspectRatio: 1.1,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (_, __, ___) =>
                      Image.asset('assets/images/image.png', fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 15),

              // Item Name
              Text(
                item.itemName ?? "Unknown Item",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialFormScreen extends StatefulWidget {
  final Items selectedSupplier;
  final MaterialTransferMaster master;
  const MaterialFormScreen(
      {super.key, required this.selectedSupplier, required this.master});

  @override
  State<MaterialFormScreen> createState() => _MaterialFormScreenScreenState();
}

class _MaterialFormScreenScreenState extends State<MaterialFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddMaterialViewModel>.reactive(
        viewModelBuilder: () => AddMaterialViewModel(),
        onViewModelReady: (model) {
          model.init(widget.selectedSupplier, widget.master);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Material Transfer Form"),
            ),
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Item Card (compact)
                      Card(
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          leading: const Icon(Icons.inventory, size: 22),
                          title: const Text(
                            "Item",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            widget.selectedSupplier.itemName ?? "",
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Warehouse dropdowns
                      SearchableDropdownField<String>(
                        selectedItem: model.item.sWarehouse,
                        label: 'Source Warehouse',
                        isRequired: true,
                        itemAsString: (item) => item,
                        items: model.warehouse,
                        onChanged: model.sWarehouse,
                      ),
                      const SizedBox(height: 8),

                      SearchableDropdownField<String>(
                        selectedItem: model.item.tWarehouse,
                        label: 'Target Warehouse',
                        isRequired: true,
                        itemAsString: (item) => item,
                        items: model.warehouse,
                        onChanged: model.tWarehouse,
                      ),
                      const SizedBox(height: 8),

                      // Qty input
                      CustomSmallTextFormField(
                          controller: model.qtyController,
                          labelText: 'Qty',
                          hintText: 'Enter Qty',
                          keyboardtype: TextInputType.number,
                          onChanged: model.setQty,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null; // ✅ must explicitly return null when valid
                          }),
                      const SizedBox(height: 12),

                      // Save button
                      SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () => model.onSavePressed(context),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          child: const Text("Save Material"),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Compact List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: model.stocks.length,
                        itemBuilder: (context, index) {
                          final purchase = model.stocks[index];
                          final isSelected =
                              model.selectedStocks.contains(purchase);

                          return GestureDetector(
                              onTap: () {
                                if (model.selectedStocks.isNotEmpty) {
                                  model.toggleSelection(purchase);
                                }
                              },
                              onLongPress: () =>
                                  model.toggleSelection(purchase),
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
                                                Colors.blue[100]!
                                                    .withOpacity(0.3),
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
                                    child: ListTile(
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                      leading: Icon(Icons.assignment,
                                          color: Colors.blue[800]),
                                      title: Text(
                                        purchase.name ?? "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      subtitle: Text(
                                        "📅 ${purchase.postingDate}",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  )));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: model.selectedStocks.isNotEmpty
                ? FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    icon: const Icon(Icons.delete),
                    label: Text(
                      'Delete (${model.selectedStocks.length})',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Delete Selected"),
                          content: Text(
                              "Are you sure you want to delete ${model.selectedStocks.length} items?"),
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
