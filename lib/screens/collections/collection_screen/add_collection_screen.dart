import 'package:flutter/material.dart';
import 'package:gaushala/constants.dart';
import 'package:gaushala/models/collection_model.dart';
import 'package:gaushala/widgets/text_button.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/customtextfield.dart';
import 'add_collection_viewmodel.dart';

class AddCollections extends StatelessWidget {
  final Items item;

  const AddCollections({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCollectionViewModel>.reactive(
      viewModelBuilder: () => AddCollectionViewModel(),
      onViewModelReady: (model) => model.init(item),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(item.itemName ?? ""),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Center(
                  child: GestureDetector(
                    onTap: () => model.selectDOB(context),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          model.dobController.text.isEmpty
                              ? "Date"
                              : model.dobController.text,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: model.selectedAnimals.isNotEmpty
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.delete),
                  label: Text(
                    'Delete (${model.selectedAnimals.length})',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Delete Selected"),
                        content: Text(
                            "Are you sure you want to delete ${model.selectedAnimals.length} items?"),
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
                      model.deleteSelectedSuppliers();
                    }
                  },
                )
              : null,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Form(
                    key: model.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: 'Filter by Shift',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                  ),
                                  value: model.collectionData.customShift,
                                  items: model.shift
                                      .map((shift) => DropdownMenuItem<String>(
                                            value: shift,
                                            child: Text(shift),
                                          ))
                                      .toList(),
                                  onChanged: model.setShift,
                                  isExpanded: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Required";
                                    }
                                    return null; // ✅ must explicitly return null when valid
                                  }),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomSmallTextFormField(
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CtextButton(
                          onPressed: () => model.onSavePressed(context),
                          text: 'Submit',
                          buttonColor: Colors.green,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 📜 FILTERED LIST VIEW
                  SizedBox(
                    height: getHeight(context) / 1.2,
                    child: model.filterAnimals.isEmpty
                        ? const Center(child: Text('No record found'))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: model.filterAnimals.length,
                            itemBuilder: (context, index) {
                              final collection = model.filterAnimals[index];
                              final parent = collection.parent ?? 'N/A';
                              final isSelected =
                                  model.selectedAnimals.contains(collection);

                              return GestureDetector(
                                onTap: () {
                                  if (model.selectedAnimals.isNotEmpty) {
                                    model.toggleSelection(collection);
                                  }
                                },
                                onLongPress: () =>
                                    model.toggleSelection(collection),
                                child: Card(
                                  elevation: 4,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  color: isSelected
                                      ? Colors.blue[50] // Softer selected color
                                      : Colors.white,
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Left icon circle

                                        const SizedBox(width: 12),

                                        // Middle content
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    parent,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    collection.date ?? "",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _infoTag(
                                                      "🐄",
                                                      collection.itemName ??
                                                          ""),
                                                  _infoTag("📦",
                                                      collection.shift ?? ""),
                                                  _infoTag(
                                                      "📏 Qty",
                                                      collection.qty
                                                          .toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Selection check icon
                                        if (isSelected)
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Icon(Icons.check_circle,
                                                color: Colors.blue, size: 26),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoTag(String emoji, String text) {
    return Row(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
