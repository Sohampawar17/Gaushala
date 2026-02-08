class ListCollection {
  String? parent;
  String? itemCode;
  String? itemName;
  String? itemGroup;
  double? qty;
  String? shift;
  String? date;

  ListCollection(
      {this.parent,
      this.itemCode,
      this.itemName,
      this.itemGroup,
      this.qty,
      this.date,
      this.shift});

  ListCollection.fromJson(Map<String, dynamic> json) {
    parent = json['parent'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemGroup = json['item_group'];
    qty = json['qty'];
    date = json['date'];
    shift = json['shift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent'] = this.parent;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['item_group'] = this.itemGroup;
    data['qty'] = this.qty;
    data['date'] = this.date;
    data['shift'] = this.shift;
    return data;
  }
}
