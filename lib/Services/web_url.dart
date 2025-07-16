class ApiUrl {
  static const String baseUrl = "https://api.pokemontcg.io/v2";

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // Example endpoints
  static const String listUrl = '$baseUrl/cards';
  static const String searchUrl = '$baseUrl/cards';
}