import 'package:gaushala/services/home_services.dart';
import 'package:stacked/stacked.dart';

class CompanyInfoViewModel extends BaseViewModel {
  Company company = Company();
  Future<void> init() async {
    setBusy(true);
    company = await HomeServices().company() as Company;
    setBusy(false);
  }
}

class Company {
  String? companyName;
  String? abbr;
  String? defaultCurrency;
  String? country;
  String? phoneNo;
  String? email;
  Address? address;
  String? companyDescription;
  String? website;
  String? gstCategory;
  String? facebook;
  String? instagram;
  String? youtube;

  Company(
      {this.companyName,
      this.abbr,
      this.defaultCurrency,
      this.country,
      this.phoneNo,
      this.email,
      this.companyDescription,
      this.address,
      this.website,
      this.gstCategory,
      this.facebook,
      this.instagram,
      this.youtube});

  Company.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    abbr = json['abbr'];
    defaultCurrency = json['default_currency'];
    country = json['country'];
    phoneNo = json['phone_no'];
    email = json['email'];
    companyDescription = json['company_description'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    website = json['website'];
    gstCategory = json['gst_category'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['abbr'] = this.abbr;
    data['default_currency'] = this.defaultCurrency;
    data['country'] = this.country;
    data['phone_no'] = this.phoneNo;
    data['company_description'] = companyDescription;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['website'] = this.website;
    data['gst_category'] = this.gstCategory;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    return data;
  }
}

class Address {
  CompanyAddress? companyAddress;
  String? companyAddressDisplay;

  Address({this.companyAddress, this.companyAddressDisplay});

  Address.fromJson(Map<String, dynamic> json) {
    companyAddress = json['company_address'] != null
        ? new CompanyAddress.fromJson(json['company_address'])
        : null;
    companyAddressDisplay = json['company_address_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.companyAddress != null) {
      data['company_address'] = this.companyAddress!.toJson();
    }
    data['company_address_display'] = this.companyAddressDisplay;
    return data;
  }
}

class CompanyAddress {
  String? companyAddress;
  String? companyAddressDisplay;

  CompanyAddress({this.companyAddress, this.companyAddressDisplay});

  CompanyAddress.fromJson(Map<String, dynamic> json) {
    companyAddress = json['company_address'];
    companyAddressDisplay = json['company_address_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_address'] = this.companyAddress;
    data['company_address_display'] = this.companyAddressDisplay;
    return data;
  }
}
