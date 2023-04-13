class Account {
  // Properties
  final String name;
  final String type;
  final String currencyCode;
  final num? available;
  final num? current;

  // Constructor
  Account.fromJson(dynamic json)
      : name = json['name'],
        type = json['type'],
        currencyCode = json['balances']['iso_currency_code'],
        available = json['balances']['available"'],
        current = json['balances']['current'];
}