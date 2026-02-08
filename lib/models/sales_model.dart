class SalesMaster {
  List<Customer>? customer;
  List<String>? item;
  List<String>? uom;
  List<String>? warehouse;
  List<CustomerList>? customerList;

  SalesMaster(
      {this.customer, this.item, this.uom, this.warehouse, this.customerList});

  SalesMaster.fromJson(Map<String, dynamic> json) {
    if (json['customer'] != null) {
      customer = <Customer>[];
      json['customer'].forEach((v) {
        customer!.add(Customer.fromJson(v));
      });
    }
    item = json['item'].cast<String>();
    uom = json['uom'].cast<String>();
    warehouse = json['warehouse'].cast<String>();
    if (json['customer_list'] != null) {
      customerList = <CustomerList>[];
      json['customer_list'].forEach((v) {
        customerList!.add(CustomerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.map((v) => v.toJson()).toList();
    }
    data['item'] = this.item;
    data['uom'] = this.uom;
    data['warehouse'] = this.warehouse;
    if (this.customerList != null) {
      data['customer_list'] =
          this.customerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String? name;
  double? balance;

  Customer({this.name, this.balance});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['balance'] = this.balance;
    return data;
  }
}

class CustomerList {
  String? name;
  String? postingDate;
  String? customer;
  double? totalQty;
  List<SalesItems>? salesItems;

  CustomerList(
      {this.name,
      this.postingDate,
      this.customer,
      this.totalQty,
      this.salesItems});

  CustomerList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postingDate = json['posting_date'];
    customer = json['customer'];
    totalQty = json['total_qty'];
    if (json['sales_items'] != null) {
      salesItems = <SalesItems>[];
      json['sales_items'].forEach((v) {
        salesItems!.add(SalesItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['posting_date'] = this.postingDate;
    data['customer'] = this.customer;
    data['total_qty'] = this.totalQty;
    if (this.salesItems != null) {
      data['sales_items'] = this.salesItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesItems {
  String? itemCode;
  String? itemName;
  double? rate;
  double? qty;
  double? amount;
  String? uom;

  SalesItems(
      {this.itemCode,
      this.itemName,
      this.rate,
      this.qty,
      this.amount,
      this.uom});

  SalesItems.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    rate = json['rate'];
    qty = json['qty'];
    amount = json['amount'];
    uom = json['uom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['rate'] = this.rate;
    data['qty'] = this.qty;
    data['amount'] = this.amount;
    data['uom'] = this.uom;
    return data;
  }
}
