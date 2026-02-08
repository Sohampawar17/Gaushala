class Animals {
  String? name;
  String? owner;
  int? docstatus;
  int? idx;
  String? animalId;
  String? animalType;
  String? gender;
  String? parent1;
  String? dateOfBirth;
  String? doctype;

  Animals(
      {this.name,
      this.owner,
      this.docstatus,
      this.idx,
      this.animalId,
      this.animalType,
      this.gender,
      this.parent1,
      this.dateOfBirth,
      this.doctype});

  Animals.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    animalId = json['animal_id'];
    animalType = json['animal_type'];
    gender = json['gender'];
    parent1 = json['parent1'];
    dateOfBirth = json['date_of_birth'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['animal_id'] = animalId;
    data['animal_type'] = animalType;
    data['gender'] = gender;
    data['parent1'] = parent1;
    data['date_of_birth'] = dateOfBirth;
    data['doctype'] = doctype;
    return data;
  }
}

class AnimalMasters {
  List<String>? animalMaster;
  List<String>? gender;
  List<Animal>? animals;

  AnimalMasters({this.animalMaster, this.gender, this.animals});

  AnimalMasters.fromJson(Map<String, dynamic> json) {
    animalMaster = json['animal_master'].cast<String>();
    gender = json['gender'].cast<String>();
    if (json['animals'] != null) {
      animals = <Animal>[];
      json['animals'].forEach((v) {
        animals!.add(Animal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['animal_master'] = animalMaster;
    data['gender'] = gender;
    if (animals != null) {
      data['animals'] = animals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Animal {
  String? name;
  String? gender;

  Animal({this.name, this.gender});

  Animal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['gender'] = gender;
    return data;
  }
}
