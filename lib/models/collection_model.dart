class Collection {
  String? name;
  String? owner;
  int? docstatus;
  int? idx;
  String? title;
  String? namingSeries;
  String? supplier;
  String? postingDate;
  String? customShift;
  int? customMobileEntry;
  String? supplierName;
  String? postingTime;
  String? currency;
  int? conversionRate;
  String? buyingPriceList;
  String? priceListCurrency;
  int? plcConversionRate;
  int? ignorePricingRule;
  int? isSubcontracted;
  int? totalQty;
  int? totalNetWeight;
  int? baseTotal;
  int? baseNetTotal;
  int? total;
  int? netTotal;
  String? doctype;
  List<Items>? items;

  Collection(
      {this.name,
      this.owner,
      this.docstatus,
      this.idx,
      this.title,
      this.namingSeries,
      this.supplier,
      this.postingDate,
      this.customShift,
      this.customMobileEntry,
      this.supplierName,
      this.postingTime,
      this.currency,
      this.conversionRate,
      this.buyingPriceList,
      this.priceListCurrency,
      this.plcConversionRate,
      this.ignorePricingRule,
      this.isSubcontracted,
      this.totalQty,
      this.totalNetWeight,
      this.baseTotal,
      this.baseNetTotal,
      this.total,
      this.netTotal,
      this.doctype,
      this.items});

  Collection.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    title = json['title'];
    namingSeries = json['naming_series'];
    supplier = json['supplier'];
    postingDate = json['posting_date'];
    customShift = json['custom_shift'];
    customMobileEntry = json['custom_mobile_entry'];
    supplierName = json['supplier_name'];
    postingTime = json['posting_time'];
    currency = json['currency'];
    conversionRate = json['conversion_rate'];
    buyingPriceList = json['buying_price_list'];
    priceListCurrency = json['price_list_currency'];
    plcConversionRate = json['plc_conversion_rate'];
    ignorePricingRule = json['ignore_pricing_rule'];
    isSubcontracted = json['is_subcontracted'];
    totalQty = json['total_qty'];
    totalNetWeight = json['total_net_weight'];
    baseTotal = json['base_total'];
    baseNetTotal = json['base_net_total'];
    total = json['total'];
    netTotal = json['net_total'];
    doctype = json['doctype'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['title'] = this.title;
    data['naming_series'] = this.namingSeries;
    data['supplier'] = this.supplier;
    data['posting_date'] = this.postingDate;
    data['custom_shift'] = this.customShift;
    data['custom_mobile_entry'] = this.customMobileEntry;
    data['supplier_name'] = this.supplierName;
    data['posting_time'] = this.postingTime;
    data['currency'] = this.currency;
    data['conversion_rate'] = this.conversionRate;
    data['buying_price_list'] = this.buyingPriceList;
    data['price_list_currency'] = this.priceListCurrency;
    data['plc_conversion_rate'] = this.plcConversionRate;
    data['ignore_pricing_rule'] = this.ignorePricingRule;
    data['is_subcontracted'] = this.isSubcontracted;
    data['total_qty'] = this.totalQty;
    data['total_net_weight'] = this.totalNetWeight;
    data['base_total'] = this.baseTotal;
    data['base_net_total'] = this.baseNetTotal;
    data['total'] = this.total;
    data['net_total'] = this.netTotal;
    data['doctype'] = this.doctype;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  String? owner;
  int? docstatus;
  int? idx;
  int? hasItemScanned;
  String? itemCode;
  String? itemName;
  String? description;
  String? gstHsnCode;
  int? isIneligibleForItc;
  String? itemGroup;
  String? image;
  int? receivedQty;
  double? qty;
  int? rejectedQty;
  String? uom;
  String? stockUom;
  int? conversionFactor;

  double? actualQty;
  int? receivedStockQty;
  int? stockQty;
  int? returnedQty;

  double? rate;
  double? amount;

  int? baseNetAmount;
  String? warehouse;

  Items({
    this.name,
    this.owner,
    this.docstatus,
    this.idx,
    this.hasItemScanned,
    this.itemCode,
    this.itemName,
    this.description,
    this.gstHsnCode,
    this.isIneligibleForItc,
    this.itemGroup,
    this.image,
    this.receivedQty,
    this.actualQty,
    this.qty,
    this.rejectedQty,
    this.uom,
    this.stockUom,
    this.conversionFactor,
    this.receivedStockQty,
    this.stockQty,
    this.returnedQty,
    this.rate,
    this.amount,
    this.baseNetAmount,
    this.warehouse,
  });

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    hasItemScanned = json['has_item_scanned'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    description = json['description'];
    gstHsnCode = json['gst_hsn_code'];
    isIneligibleForItc = json['is_ineligible_for_itc'];
    itemGroup = json['item_group'];
    image = json['image'];
    receivedQty = json['received_qty'];
    qty = json['qty'];
    actualQty = json['actual_qty'];
    rejectedQty = json['rejected_qty'];
    uom = json['uom'];
    stockUom = json['stock_uom'];
    conversionFactor = json['conversion_factor'];

    receivedStockQty = json['received_stock_qty'];
    stockQty = json['stock_qty'];
    returnedQty = json['returned_qty'];

    rate = json['rate'];
    amount = json['amount'];

    baseNetAmount = json['base_net_amount'];
    warehouse = json['warehouse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['has_item_scanned'] = this.hasItemScanned;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['gst_hsn_code'] = this.gstHsnCode;
    data['is_ineligible_for_itc'] = this.isIneligibleForItc;
    data['item_group'] = this.itemGroup;
    data['image'] = this.image;
    data['received_qty'] = this.receivedQty;
    data['qty'] = this.qty;
    data['actual_qty'] = actualQty;

    data['rejected_qty'] = this.rejectedQty;
    data['uom'] = this.uom;
    data['stock_uom'] = this.stockUom;
    data['conversion_factor'] = this.conversionFactor;

    data['received_stock_qty'] = this.receivedStockQty;
    data['stock_qty'] = this.stockQty;
    data['returned_qty'] = this.returnedQty;

    data['rate'] = this.rate;
    data['amount'] = this.amount;

    data['base_net_amount'] = this.baseNetAmount;
    data['warehouse'] = this.warehouse;

    return data;
  }
}
