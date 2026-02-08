class Sale {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  String? namingSeries;
  String? customer;
  String? postingDate;
  String? company;
  int? customMobileEntry;
  int? isExportWithGst;
  String? customShift;
  String? customerName;
  int? isReverseCharge;
  int? setPostingTime;
  String? postingTime;
  int? issueCreditNote;
  int? isReturn;
  String? currency;
  double? totalQty;
  int? totalNetWeight;
  double? baseTotal;
  double? baseNetTotal;
  double? total;
  double? netTotal;
  String? taxCategory;
  List<Items>? items;

  Sale(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.namingSeries,
      this.customer,
      this.postingDate,
      this.company,
      this.customShift,
      this.customMobileEntry,
      this.isExportWithGst,
      this.customerName,
      this.isReverseCharge,
      this.setPostingTime,
      this.postingTime,
      this.issueCreditNote,
      this.isReturn,
      this.currency,
      this.totalQty,
      this.totalNetWeight,
      this.baseTotal,
      this.baseNetTotal,
      this.total,
      this.netTotal,
      this.taxCategory,
      this.items});

  Sale.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    namingSeries = json['naming_series'];
    customer = json['customer'];
    postingDate = json['posting_date'];
    company = json['company'];
    customShift = json['custom_shift'];
    customMobileEntry = json['custom_mobile_entry'];
    isExportWithGst = json['is_export_with_gst'];
    customerName = json['customer_name'];
    isReverseCharge = json['is_reverse_charge'];
    setPostingTime = json['set_posting_time'];
    postingTime = json['posting_time'];
    issueCreditNote = json['issue_credit_note'];
    isReturn = json['is_return'];
    currency = json['currency'];
    totalQty = json['total_qty'];
    totalNetWeight = json['total_net_weight'];
    baseTotal = json['base_total'];
    baseNetTotal = json['base_net_total'];
    total = json['total'];
    netTotal = json['net_total'];
    taxCategory = json['tax_category'];
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
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['naming_series'] = this.namingSeries;
    data['customer'] = this.customer;
    data['custom_shift'] = this.customShift;
    data['posting_date'] = this.postingDate;
    data['company'] = this.company;
    data['custom_mobile_entry'] = this.customMobileEntry;
    data['is_export_with_gst'] = this.isExportWithGst;
    data['customer_name'] = this.customerName;
    data['is_reverse_charge'] = this.isReverseCharge;
    data['set_posting_time'] = this.setPostingTime;
    data['posting_time'] = this.postingTime;
    data['issue_credit_note'] = this.issueCreditNote;
    data['is_return'] = this.isReturn;
    data['currency'] = this.currency;
    data['total_qty'] = this.totalQty;
    data['total_net_weight'] = this.totalNetWeight;
    data['base_total'] = this.baseTotal;
    data['base_net_total'] = this.baseNetTotal;
    data['total'] = this.total;
    data['net_total'] = this.netTotal;
    data['tax_category'] = this.taxCategory;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  String? itemCode;
  String? itemName;
  String? description;
  String? gstHsnCode;
  String? itemGroup;
  String? image;
  double? qty;
  String? stockUom;
  String? uom;
  int? conversionFactor;
  int? stockQty;
  int? returnedQty;
  int? priceListRate;
  int? basePriceListRate;
  String? marginType;
  int? marginRateOrAmount;
  int? rateWithMargin;
  int? discountPercentage;
  int? discountAmount;
  int? baseRateWithMargin;
  double? rate;
  double? amount;
  int? baseRate;
  int? baseAmount;
  String? pricingRules;
  int? stockUomRate;
  int? isFreeItem;
  String? warehouse;

  int? grantCommission;
  int? netRate;
  int? netAmount;

  Items(
      {this.name,
      this.itemCode,
      this.itemName,
      this.description,
      this.gstHsnCode,
      this.itemGroup,
      this.image,
      this.qty,
      this.stockUom,
      this.uom,
      this.conversionFactor,
      this.stockQty,
      this.returnedQty,
      this.priceListRate,
      this.basePriceListRate,
      this.warehouse,
      this.marginType,
      this.marginRateOrAmount,
      this.rateWithMargin,
      this.discountPercentage,
      this.discountAmount,
      this.baseRateWithMargin,
      this.rate,
      this.amount,
      this.baseRate,
      this.baseAmount,
      this.pricingRules,
      this.stockUomRate,
      this.isFreeItem,
      this.grantCommission,
      this.netRate,
      this.netAmount});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    description = json['description'];
    gstHsnCode = json['gst_hsn_code'];
    itemGroup = json['item_group'];
    image = json['image'];
    qty = json['qty'];
    stockUom = json['stock_uom'];
    uom = json['uom'];
    conversionFactor = json['conversion_factor'];
    stockQty = json['stock_qty'];
    warehouse = json["warehouse"];
    returnedQty = json['returned_qty'];
    priceListRate = json['price_list_rate'];
    basePriceListRate = json['base_price_list_rate'];
    marginType = json['margin_type'];
    marginRateOrAmount = json['margin_rate_or_amount'];
    rateWithMargin = json['rate_with_margin'];
    discountPercentage = json['discount_percentage'];
    discountAmount = json['discount_amount'];
    baseRateWithMargin = json['base_rate_with_margin'];
    rate = json['rate'];
    amount = json['amount'];
    baseRate = json['base_rate'];
    baseAmount = json['base_amount'];
    pricingRules = json['pricing_rules'];
    stockUomRate = json['stock_uom_rate'];
    isFreeItem = json['is_free_item'];
    grantCommission = json['grant_commission'];
    netRate = json['net_rate'];
    netAmount = json['net_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['gst_hsn_code'] = this.gstHsnCode;
    data['item_group'] = this.itemGroup;
    data['image'] = this.image;
    data['qty'] = this.qty;
    data['stock_uom'] = this.stockUom;
    data['uom'] = this.uom;
    data['warehouse'] = this.warehouse;
    data['conversion_factor'] = this.conversionFactor;
    data['stock_qty'] = this.stockQty;
    data['returned_qty'] = this.returnedQty;
    data['price_list_rate'] = this.priceListRate;
    data['base_price_list_rate'] = this.basePriceListRate;
    data['margin_type'] = this.marginType;
    data['margin_rate_or_amount'] = this.marginRateOrAmount;
    data['rate_with_margin'] = this.rateWithMargin;
    data['discount_percentage'] = this.discountPercentage;
    data['discount_amount'] = this.discountAmount;
    data['base_rate_with_margin'] = this.baseRateWithMargin;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['base_rate'] = this.baseRate;
    data['base_amount'] = this.baseAmount;
    data['pricing_rules'] = this.pricingRules;
    data['stock_uom_rate'] = this.stockUomRate;
    data['is_free_item'] = this.isFreeItem;
    data['grant_commission'] = this.grantCommission;
    data['net_rate'] = this.netRate;
    data['net_amount'] = this.netAmount;
    return data;
  }
}
