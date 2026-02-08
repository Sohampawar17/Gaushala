import 'package:flutter/material.dart';
import 'package:gaushala/widgets/text_button.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/customtextfield.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/full_screen_loader.dart';
import 'add_cow_viewmodel.dart';

class AddAnimal extends StatelessWidget {
  final String id;

  const AddAnimal({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddAnimalViewModel>.reactive(
      viewModelBuilder: () => AddAnimalViewModel(),
      onViewModelReady: (model) {
        model.init(id);
      },
      builder: (context, model, child) {
        return fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Add Animal'),
              centerTitle: true,
              elevation: 2,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    const Text(
                      'Animal Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomSmallTextFormField(
                      controller: model.idController,
                      labelText: 'Cow Id',
                      hintText: 'Enter Cow Id',
                      onChanged: model.setId,
                    ),
                    const SizedBox(height: 20),
                    // DOB Field
                    TextFormField(
                      readOnly: true,
                      controller: model.dobController,
                      onTap: () => model.selectDOB(context),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 16.0),
                        labelText: 'Date Of Birth',
                        hintText: 'Select DOB',
                        prefixIcon: const Icon(Icons.calendar_today_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Animal Type Dropdown
                    SearchableDropdownField<String>(
                      selectedItem: model.animalData.animalType,
                      label: 'Animal Type',
                      isRequired: true,
                      itemAsString: (item) => item,
                      items: model.animalType,
                      onChanged: model.setAnimalType,
                    ),
                    const SizedBox(height: 20),

                    // Gender Dropdown
                    SearchableDropdownField<String>(
                      selectedItem: model.animalData.gender,
                      label: 'Gender',
                      isRequired: true,
                      itemAsString: (item) => item,
                      items: model.gender,
                      onChanged: model.setGender,
                    ),
                    const SizedBox(height: 20),

                    SearchableDropdownField<String>(
                      selectedItem: model.animalData.parent1,
                      label: 'Parent',
                      isRequired: true,
                      itemAsString: (item) => item ?? "N/A",
                      items:
                          model.filterAnimals.map((a) => a.name ?? "").toList(),
                      onChanged: (value) => model.setParentName(value),
                    ),

                    const SizedBox(height: 30),

                    const Divider(height: 1, thickness: 1),
                    const SizedBox(height: 20),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: CtextButton(
                            onPressed: () => Navigator.pop(context),
                            text: 'Cancel',
                            buttonColor: Colors.red.shade400,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CtextButton(
                            onPressed: () => model.onSavePressed(context),
                            text: 'Submit',
                            buttonColor: Colors.green.shade600,
                          ),
                        ),
                      ],
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
}
