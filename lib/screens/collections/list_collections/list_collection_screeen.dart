import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'list_collection_viewmodel.dart';

class ListCollectionScreen extends StatelessWidget {
  const ListCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListCollectionViewModel>.reactive(
      viewModelBuilder: () => ListCollectionViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white.withOpacity(0.9),
            elevation: 4,
            title: const Center(
              child: Text(
                'Collections',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFD700), Color(0xFFFFFF99)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : model.filterAnimals.isEmpty
                    ? const Center(child: Text('No record found'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: model.filterAnimals.length,
                        itemBuilder: (context, index) {
                          final collection = model.filterAnimals[index];

                          final parent = collection.parent ?? 'N/A';

                          final isSelected =
                              model.selectedAnimals.contains(collection);

                          return GestureDetector(
                            onLongPress: () =>
                                model.toggleSelection(collection),
                            child: Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 6,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: isSelected
                                  ? Colors.blue[100]!.withOpacity(0.95)
                                  : Colors.white.withOpacity(0.95),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border(
                                    left: BorderSide(
                                      color: Colors.blue[900]!,
                                      width: 5,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 14,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "🧾 $parent",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "🐄 ${collection.itemName}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                "📦 ${collection.shift}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                "📦 ${collection.qty}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.blue,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}
