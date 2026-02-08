import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaushala/screens/collections/collection_screen/add_collection_screen.dart';
import 'package:stacked/stacked.dart';

import 'collections_item_viewmodel.dart';

class CollectionsItems extends StatelessWidget {
  const CollectionsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CollectionItemsViewModel>.reactive(
      viewModelBuilder: () => CollectionItemsViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Collections Items')),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    itemCount: model.items.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final item = model.items[index];
                      final imageUrl = item.image ??
                          'http://schoolssportswear.com/img/nopdt.jpg';

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddCollections(item: item),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Item Image
                              AspectRatio(
                                aspectRatio: 1.1,
                                child: CachedNetworkImage(
                                  imageUrl: item.image ?? '',
                                  fit: BoxFit.fill,
                                  placeholder: (_, __) => const Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                  errorWidget: (_, __, ___) => Image.asset(
                                    'assets/images/image.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                              // Info
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Item Name
                                    Row(
                                      children: [
                                        const Icon(Icons.shopping_bag_outlined,
                                            size: 18, color: Colors.blueGrey),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            item.itemName ?? 'No Name',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.inventory_2_rounded,
                                              size: 18,
                                              color: Colors.deepPurple,
                                            ),
                                            const SizedBox(width: 6),
                                            const Text(
                                              'Milk:',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${item.actualQty ?? 0} Ltr',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Optional: Add a Chip or Badge here for Stock or UOM
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
