class Transaction {
  // Properties
  final String date;
  final num amount;
  final String currencyCode;
  final String merchantName;
  final List<String> categories;

  // Constructor
  Transaction.fromJson(dynamic json)
      : date = json['date'],
        amount = json['amount'],
        currencyCode = json['iso_currency_code'],
        merchantName = json['name'],
        categories = (json['category'] as List<dynamic>).cast<String>();
}