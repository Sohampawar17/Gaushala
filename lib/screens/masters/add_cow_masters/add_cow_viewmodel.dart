import 'package:flutter/material.dart';
import 'package:gaushala/models/animals_model.dart';
import 'package:gaushala/router.router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../services/animal_service.dart';

class AddAnimalViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedDOB;
  Animals animalData = Animals();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  bool isEdit = false;
  List<String> animalType = [];
  List<String> gender = [];
  AnimalMasters masters = AnimalMasters();
  List<Animal> animals = [];
  List<Animal> filterAnimals = [];

  void init(String id) async {
    setBusy(true);
    masters = await AnimalService().masters() ?? AnimalMasters();
    animalType = masters.animalMaster ?? [];
    animals = masters.animals ?? [];
    filterAnimals = animals;
    gender = masters.gender ?? [];
    if (id.isNotEmpty) {
      animalData = await AnimalService().get(id) ?? Animals();
      isEdit = true;
      idController.text = animalData.animalId ?? "";
      dobController.text = animalData.dateOfBirth ?? "";
    }
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      bool res = false;
      if (isEdit == true) {
        res = await AnimalService().update(animalData);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            Navigator.pushReplacementNamed(context, Routes.listAnimalScreen);
          }
        }
      } else {
        res = await AnimalService().create(animalData);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            Navigator.pushReplacementNamed(context, Routes.listAnimalScreen);
          }
        }
      }
    }
    setBusy(false);
  }

  Future<void> selectDOB(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDOB ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDOB = picked;
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      animalData.dateOfBirth = dobController.text;
      notifyListeners();
    }
  }

  void setGender(String? gender) {
    animalData.gender = gender;

    if (gender != null && gender.isNotEmpty) {
      filterAnimals = animals
          .where(
              (animal) => animal.gender?.toLowerCase() == gender.toLowerCase())
          .toList();
    } else {
      // if no gender selected, show all
      filterAnimals = List.from(animals);
    }

    notifyListeners();
  }

  void setId(String? id) {
    idController.text = id ?? "";
    animalData.animalId = id;
    notifyListeners();
  }

  void setAnimalType(String? animalType) {
    animalData.animalType = animalType;
    notifyListeners();
  }

  void setParentName(String? parentName) {
    animalData.parent1 = parentName ?? "";
    notifyListeners();
  }
}
