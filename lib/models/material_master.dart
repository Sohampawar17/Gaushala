import 'package:gaushala/models/material_transfer.dart';

class MaterialTransferMaster {
  List<Items>? item;
  List<String>? uom;
  List<String>? warehouse;
  List<StockList>? stockList;

  MaterialTransferMaster({this.item, this.uom, this.warehouse, this.stockList});

  MaterialTransferMaster.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <Items>[];
      json['item'].forEach((v) {
        item!.add(new Items.fromJson(v));
      });
    }
    uom = json['uom'].cast<String>();
    warehouse = json['warehouse'].cast<String>();
    if (json['stock_list'] != null) {
      stockList = <StockList>[];
      json['stock_list'].forEach((v) {
        stockList!.add(new StockList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    data['uom'] = this.uom;
    data['warehouse'] = this.warehouse;
    if (this.stockList != null) {
      data['stock_list'] = this.stockList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String? name;
  String? itemName;
  String? itemCode;
  String? image;

  Item({this.name, this.itemName, this.itemCode, this.image});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['image'] = this.image;
    return data;
  }
}

class StockList {
  String? name;
  String? postingDate;

  StockList({this.name, this.postingDate});

  StockList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postingDate = json['posting_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['posting_date'] = this.postingDate;
    return data;
  }
}
