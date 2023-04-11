class Constants {

  // Sandbox Plaid API keys
  // TODO: Get those keys from a configuration endpoint
  static const String kClientId = '6423114a221ca500121af565';
  static const String kClientSecret = 'dfb8cf8088f72370e1de70c90b62e6';

  static const String kHost = 'sandbox.plaid.com';
  static const String kLinkTokenEndpoint = '/link/token/create';
  static const String kTokenExchangeEndpoint = '/item/public_token/exchange';
  static const String kTransactionsEndpoint = '/transactions/sync';
  static const String kAccountsEndpoint = '/auth/get';

  // String constants
  static const String kHeroImage = 'assets/images/flutter-hero.png';

  // Attributes
  static const String kLinkTokenAttribute = 'link_token';
  static const String kAccessTokenAttribute = 'access_token';

  // Share Preferences
  static const kPublicToken = 'PUBLIC_TOKEN';
  static const kAccessToken = 'ACCESS_TOKEN';

}
