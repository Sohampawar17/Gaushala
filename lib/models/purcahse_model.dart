class PurchaseMaster {
  List<Supplier>? supplier;
  List<String>? item;
  List<String>? uom;
  List<String>? warehouse;
  List<PurchaseList>? purchaseList;

  PurchaseMaster(
      {this.supplier, this.item, this.uom, this.warehouse, this.purchaseList});

  PurchaseMaster.fromJson(Map<String, dynamic> json) {
    if (json['supplier'] != null) {
      supplier = <Supplier>[];
      json['supplier'].forEach((v) {
        supplier!.add(new Supplier.fromJson(v));
      });
    }
    item = json['item'].cast<String>();
    uom = json['uom'].cast<String>();
    warehouse = json['warehouse'].cast<String>();
    if (json['purchase_list'] != null) {
      purchaseList = <PurchaseList>[];
      json['purchase_list'].forEach((v) {
        purchaseList!.add(new PurchaseList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.map((v) => v.toJson()).toList();
    }
    data['item'] = this.item;
    data['uom'] = this.uom;
    data['warehouse'] = this.warehouse;
    if (this.purchaseList != null) {
      data['purchase_list'] =
          this.purchaseList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Supplier {
  String? name;
  double? balance;

  Supplier({this.name, this.balance});

  Supplier.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['balance'] = this.balance;
    return data;
  }
}

class PurchaseList {
  String? name;
  String? postingDate;
  String? supplier;
  double? totalQty;
  List<PurchaseItems>? purchaseItems;

  PurchaseList(
      {this.name,
      this.postingDate,
      this.supplier,
      this.totalQty,
      this.purchaseItems});

  PurchaseList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postingDate = json['posting_date'];
    supplier = json['supplier'];
    totalQty = json['total_qty'];
    if (json['purchase_items'] != null) {
      purchaseItems = <PurchaseItems>[];
      json['purchase_items'].forEach((v) {
        purchaseItems!.add(new PurchaseItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['posting_date'] = this.postingDate;
    data['supplier'] = this.supplier;
    data['total_qty'] = this.totalQty;
    if (this.purchaseItems != null) {
      data['purchase_items'] =
          this.purchaseItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseItems {
  String? itemCode;
  String? itemName;
  double? rate;
  double? qty;
  double? amount;
  String? uom;

  PurchaseItems(
      {this.itemCode,
      this.itemName,
      this.rate,
      this.qty,
      this.amount,
      this.uom});

  PurchaseItems.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    rate = json['rate'];
    qty = json['qty'];
    amount = json['amount'];
    uom = json['uom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['rate'] = this.rate;
    data['qty'] = this.qty;
    data['amount'] = this.amount;
    data['uom'] = this.uom;
    return data;
  }
}
