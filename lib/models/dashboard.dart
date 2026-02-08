class Dashboard {
  String? user;
  String? username;
  double? totalStockQty;
  int? totalAnimals;
  int? maleAnimals;
  int? femaleAnimals;
  List<AnimalsByTypeAndGender>? animalsByTypeAndGender;

  Dashboard(
      {this.user,
      this.username,
      this.totalStockQty,
      this.totalAnimals,
      this.maleAnimals,
      this.femaleAnimals,
      this.animalsByTypeAndGender});

  Dashboard.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    username = json['username'];
    totalStockQty = json['total_stock_qty'];
    totalAnimals = json['total_animals'];
    maleAnimals = json['male_animals'];
    femaleAnimals = json['female_animals'];
    if (json['animals_by_type_and_gender'] != null) {
      animalsByTypeAndGender = <AnimalsByTypeAndGender>[];
      json['animals_by_type_and_gender'].forEach((v) {
        animalsByTypeAndGender!.add(AnimalsByTypeAndGender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = this.user;
    data['username'] = this.username;
    data['total_stock_qty'] = this.totalStockQty;
    data['total_animals'] = this.totalAnimals;
    data['male_animals'] = this.maleAnimals;
    data['female_animals'] = this.femaleAnimals;
    if (this.animalsByTypeAndGender != null) {
      data['animals_by_type_and_gender'] =
          this.animalsByTypeAndGender!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnimalsByTypeAndGender {
  String? animalType;
  int? male;
  int? female;
  int? total;
  double? actualQty;

  AnimalsByTypeAndGender(
      {this.animalType, this.male, this.female, this.total, this.actualQty});

  AnimalsByTypeAndGender.fromJson(Map<String, dynamic> json) {
    animalType = json['animal_type'];
    male = json['male'];
    female = json['female'];
    total = json['total'];
    actualQty = json['actual_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['animal_type'] = this.animalType;
    data['male'] = this.male;
    data['total'] = this.total;
    data['female'] = this.female;
    data['actual_qty'] = this.actualQty;
    return data;
  }
}
