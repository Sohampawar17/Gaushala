import 'package:flutter/material.dart';
import 'package:gaushala/router.router.dart';
import 'package:stacked/stacked.dart';

import 'list_animals_viewmodel.dart';

class ListAnimalScreen extends StatelessWidget {
  const ListAnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListAnimalViewModel>.reactive(
      viewModelBuilder: () => ListAnimalViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 4,
            title: Text(
              model.isSelectionMode ? 'Select Cow' : 'Cow',
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            actions: [
              if (model.isSelectionMode)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text('Delete selected cows?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('No')),
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Yes')),
                        ],
                      ),
                    );
                    if (confirm == true) await model.deleteSelectedSuppliers();
                  },
                )
            ],
          ),
          body: Container(
              child: model.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : model.filterAnimals.isEmpty
                      ? const Center(child: Text('No Cow found'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: model.filterAnimals.length,
                          itemBuilder: (context, index) {
                            final cow = model.filterAnimals[index];
                            final isSelected = model.isSelected(cow);

                            // Calculate age from DOB
                            String? age;
                            if (cow.dateOfBirth != null) {
                              final dob = DateTime.tryParse(cow.dateOfBirth!);
                              if (dob != null) {
                                final today = DateTime.now();
                                final years = today.year - dob.year;
                                final months = today.month - dob.month;
                                final days = today.day - dob.day;
                                int actualYears = years;
                                if (months < 0 || (months == 0 && days < 0)) {
                                  actualYears--;
                                }
                                age = "$actualYears yrs";
                              }
                            }

                            return GestureDetector(
                              onLongPress: () => model.toggleSelection(cow),
                              onTap: () async {
                                if (model.isSelectionMode) {
                                  model.toggleSelection(cow);
                                } else {
                                  await Navigator.pushNamed(
                                    context,
                                    Routes.addAnimal,
                                    arguments: AddAnimalArguments(
                                        id: cow.name.toString()),
                                  );
                                  model.fetchSuppliers();
                                }
                              },
                              child: Card(
                                color: isSelected
                                    ? Colors.blue[100]
                                    : Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue[50],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(Icons.pets_outlined,
                                            color: Colors.blue[900], size: 28),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Name and animal type
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    cow.name ?? "",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                                if (cow.animalType != null)
                                                  Text(
                                                    "🐄 ${cow.animalType}",
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),

                                            // Date of birth, age, gender
                                            Row(
                                              children: [
                                                if (cow.dateOfBirth != null)
                                                  Text(
                                                    "📆 ${cow.dateOfBirth}",
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                if (age != null)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "🎂 $age",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                if (cow.gender != null)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "⚥ ${cow.gender}",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),

                                            const SizedBox(height: 6),

                                            // Parent1
                                            if (cow.parent1 != null &&
                                                cow.parent1!.isNotEmpty)
                                              Row(
                                                children: [
                                                  const Text(
                                                    "👤 Parent: ",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      cow.parent1!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, Routes.addAnimal,
                  arguments: const AddAnimalArguments(id: ''));
            },
            label: const Text('Add Animal'),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
