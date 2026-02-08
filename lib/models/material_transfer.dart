class MaterialTransfer {
  String? name;
  String? owner;
  String? stockEntryType;
  String? purpose;
  int? addToTransit;
  String? company;
  String? postingTime;
  int? setPostingTime;
  int? docstatus;
  int? customMobileAppEntry;
  List<Items>? items;

  MaterialTransfer(
      {this.name,
      this.owner,
      this.stockEntryType,
      this.purpose,
      this.addToTransit,
      this.company,
      this.docstatus,
      this.postingTime,
      this.setPostingTime,
      this.customMobileAppEntry,
      this.items});

  MaterialTransfer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    stockEntryType = json['stock_entry_type'];
    purpose = json['purpose'];
    addToTransit = json['add_to_transit'];
    company = json['company'];
    docstatus = json['docstatus'];
    postingTime = json['posting_time'];
    setPostingTime = json['set_posting_time'];
    customMobileAppEntry = json['custom_mobile_app_entry'];
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
    data['stock_entry_type'] = this.stockEntryType;
    data['purpose'] = this.purpose;
    data['add_to_transit'] = this.addToTransit;
    data['company'] = this.company;
    data['docstatus'] = docstatus;
    data['posting_time'] = this.postingTime;
    data['set_posting_time'] = this.setPostingTime;
    data['custom_mobile_app_entry'] = this.customMobileAppEntry;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  int? idx;
  int? hasItemScanned;
  String? sWarehouse;
  String? tWarehouse;
  String? itemCode;
  String? itemName;
  int? isFinishedItem;
  int? isScrapItem;
  String? description;
  String? gstHsnCode;
  String? itemGroup;
  String? image;
  double? qty;
  int? transferQty;
  int? retainSample;
  String? uom;
  String? stockUom;
  int? conversionFactor;
  int? sampleQuantity;
  double? basicRate;
  int? additionalCost;
  int? valuationRate;
  int? allowZeroValuationRate;
  int? setBasicRateManually;
  int? basicAmount;
  double? amount;
  int? useSerialBatchFields;
  String? expenseAccount;
  String? costCenter;
  double? actualQty;
  int? transferredQty;

  Items(
      {this.name,
      this.idx,
      this.hasItemScanned,
      this.sWarehouse,
      this.tWarehouse,
      this.itemCode,
      this.itemName,
      this.isFinishedItem,
      this.isScrapItem,
      this.description,
      this.gstHsnCode,
      this.itemGroup,
      this.image,
      this.qty,
      this.transferQty,
      this.retainSample,
      this.uom,
      this.stockUom,
      this.conversionFactor,
      this.sampleQuantity,
      this.basicRate,
      this.additionalCost,
      this.valuationRate,
      this.allowZeroValuationRate,
      this.setBasicRateManually,
      this.basicAmount,
      this.amount,
      this.useSerialBatchFields,
      this.expenseAccount,
      this.costCenter,
      this.actualQty,
      this.transferredQty});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    idx = json['idx'];
    hasItemScanned = json['has_item_scanned'];
    sWarehouse = json['s_warehouse'];
    tWarehouse = json['t_warehouse'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    isFinishedItem = json['is_finished_item'];
    isScrapItem = json['is_scrap_item'];
    description = json['description'];
    gstHsnCode = json['gst_hsn_code'];
    itemGroup = json['item_group'];
    image = json['image'];
    qty = json['qty'];
    transferQty = json['transfer_qty'];
    retainSample = json['retain_sample'];
    uom = json['uom'];
    stockUom = json['stock_uom'];
    conversionFactor = json['conversion_factor'];
    sampleQuantity = json['sample_quantity'];
    basicRate = json['basic_rate'];
    additionalCost = json['additional_cost'];
    valuationRate = json['valuation_rate'];
    allowZeroValuationRate = json['allow_zero_valuation_rate'];
    setBasicRateManually = json['set_basic_rate_manually'];
    basicAmount = json['basic_amount'];
    amount = json['amount'];
    useSerialBatchFields = json['use_serial_batch_fields'];
    expenseAccount = json['expense_account'];
    costCenter = json['cost_center'];
    actualQty = json['actual_qty'];
    transferredQty = json['transferred_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['idx'] = this.idx;
    data['has_item_scanned'] = this.hasItemScanned;
    data['s_warehouse'] = this.sWarehouse;
    data['t_warehouse'] = this.tWarehouse;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['is_finished_item'] = this.isFinishedItem;
    data['is_scrap_item'] = this.isScrapItem;
    data['description'] = this.description;
    data['gst_hsn_code'] = this.gstHsnCode;
    data['item_group'] = this.itemGroup;
    data['image'] = this.image;
    data['qty'] = this.qty;
    data['transfer_qty'] = this.transferQty;
    data['retain_sample'] = this.retainSample;
    data['uom'] = this.uom;
    data['stock_uom'] = this.stockUom;
    data['conversion_factor'] = this.conversionFactor;
    data['sample_quantity'] = this.sampleQuantity;
    data['basic_rate'] = this.basicRate;
    data['additional_cost'] = this.additionalCost;
    data['valuation_rate'] = this.valuationRate;
    data['allow_zero_valuation_rate'] = this.allowZeroValuationRate;
    data['set_basic_rate_manually'] = this.setBasicRateManually;
    data['basic_amount'] = this.basicAmount;
    data['amount'] = this.amount;
    data['use_serial_batch_fields'] = this.useSerialBatchFields;
    data['expense_account'] = this.expenseAccount;
    data['cost_center'] = this.costCenter;
    data['actual_qty'] = this.actualQty;
    data['transferred_qty'] = this.transferredQty;
    return data;
  }
}
