// Root model
class PokemonCardResponse {
  final List<PokemonCard> data;
  final int page;
  final int pageSize;
  final int count;
  final int totalCount;

  PokemonCardResponse({
    required this.data,
    required this.page,
    required this.pageSize,
    required this.count,
    required this.totalCount,
  });

  factory PokemonCardResponse.fromJson(Map<String, dynamic> json) {
    return PokemonCardResponse(
      data: List<PokemonCard>.from(
        json['data'].map((x) => PokemonCard.fromJson(x)),
      ),
      page: json['page'],
      pageSize: json['pageSize'],
      count: json['count'],
      totalCount: json['totalCount'],
    );
  }
}

// Main card model
class PokemonCard {
  final String id;
  final String name;
  final String supertype;
  final List<String> subtypes;
  final String hp;
  final List<String>? types;
  final String? evolvesFrom;
  final List<Attack>? attacks;
  final List<Weakness>? weaknesses;
  final List<Resistance>? resistances;
  final List<String>? retreatCost;
  final int convertedRetreatCost;
  final SetInfo? set;
  final String number;
  final String artist;
  final String? rarity;
  final String? flavorText;
  final List<int> nationalPokedexNumbers;
  final Legalities legalities;
  final ImageLinks images;
  final TcgPlayer? tcgplayer;
  final CardMarket? cardmarket;

  PokemonCard({
    required this.id,
    required this.name,
    required this.supertype,
    required this.subtypes,
    required this.hp,
    required this.types,
    this.evolvesFrom,
    this.attacks,
    this.weaknesses,
    this.resistances,
    this.retreatCost,
    required this.convertedRetreatCost,
    this.set,
    required this.number,
    required this.artist,
    this.rarity,
    this.flavorText,
    required this.nationalPokedexNumbers,
    required this.legalities,
    required this.images,
    this.tcgplayer,
    this.cardmarket,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'],
      name: json['name'],
      supertype: json['supertype'],
      subtypes: List<String>.from(json['subtypes']),
      hp: json['hp'] ?? '',
      types: json['types'] != null ? List<String>.from(json['types']) : null,
      evolvesFrom: json['evolvesFrom'],
      attacks:
          json['attacks'] != null
              ? List<Attack>.from(
                json['attacks'].map((x) => Attack.fromJson(x)),
              )
              : null,
      weaknesses:
          json['weaknesses'] != null
              ? List<Weakness>.from(
                json['weaknesses'].map((x) => Weakness.fromJson(x)),
              )
              : null,
      resistances:
          json['resistances'] != null
              ? List<Resistance>.from(
                json['resistances'].map((x) => Resistance.fromJson(x)),
              )
              : null,
      retreatCost:
          json['retreatCost'] != null
              ? List<String>.from(json['retreatCost'])
              : null,
      convertedRetreatCost: json['convertedRetreatCost'] ?? 0,
      set: json['set'] != null ? SetInfo.fromJson(json['set']) : null,
      number: json['number'],
      artist: json['artist'],
      rarity: json['rarity'],
      flavorText: json['flavorText'],
      nationalPokedexNumbers: List<int>.from(json['nationalPokedexNumbers']),
      legalities: Legalities.fromJson(json['legalities']),
      images: ImageLinks.fromJson(json['images']),
      tcgplayer:
          json['tcgplayer'] != null
              ? TcgPlayer.fromJson(json['tcgplayer'])
              : null,
      cardmarket:
          json['cardmarket'] != null
              ? CardMarket.fromJson(json['cardmarket'])
              : null,
    );
  }
}

// Nested models
class Attack {
  final String name;
  final List<String> cost;
  final int convertedEnergyCost;
  final String damage;
  final String text;

  Attack({
    required this.name,
    required this.cost,
    required this.convertedEnergyCost,
    required this.damage,
    required this.text,
  });

  factory Attack.fromJson(Map<String, dynamic> json) {
    return Attack(
      name: json['name'],
      cost: List<String>.from(json['cost']),
      convertedEnergyCost: json['convertedEnergyCost'],
      damage: json['damage'],
      text: json['text'],
    );
  }
}

class Weakness {
  final String type;
  final String value;

  Weakness({required this.type, required this.value});

  factory Weakness.fromJson(Map<String, dynamic> json) {
    return Weakness(type: json['type'], value: json['value']);
  }
}

class Resistance {
  final String type;
  final String value;

  Resistance({required this.type, required this.value});

  factory Resistance.fromJson(Map<String, dynamic> json) {
    return Resistance(type: json['type'], value: json['value']);
  }
}

class SetInfo {
  final String id;
  final String name;
  final String series;
  final int printedTotal;
  final int total;
  final Legalities legalities;
  final String? ptcgoCode;
  final String releaseDate;
  final String updatedAt;
  final SetImages images;

  SetInfo({
    required this.id,
    required this.name,
    required this.series,
    required this.printedTotal,
    required this.total,
    required this.legalities,
    this.ptcgoCode,
    required this.releaseDate,
    required this.updatedAt,
    required this.images,
  });

  factory SetInfo.fromJson(Map<String, dynamic> json) {
    return SetInfo(
      id: json['id'],
      name: json['name'],
      series: json['series'],
      printedTotal: json['printedTotal'],
      total: json['total'],
      legalities: Legalities.fromJson(json['legalities']),
      ptcgoCode: json['ptcgoCode'],
      releaseDate: json['releaseDate'],
      updatedAt: json['updatedAt'],
      images: SetImages.fromJson(json['images']),
    );
  }
}

class Legalities {
  final String unlimited;
  final String? expanded;

  Legalities({required this.unlimited, this.expanded});

  factory Legalities.fromJson(Map<String, dynamic> json) {
    return Legalities(unlimited: json['unlimited'], expanded: json['expanded']);
  }
}

class ImageLinks {
  final String small;
  final String large;

  ImageLinks({required this.small, required this.large});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(small: json['small'], large: json['large']);
  }
}

class SetImages {
  final String symbol;
  final String logo;

  SetImages({required this.symbol, required this.logo});

  factory SetImages.fromJson(Map<String, dynamic> json) {
    return SetImages(symbol: json['symbol'], logo: json['logo']);
  }
}

class TcgPlayer {
  final String url;
  final String updatedAt;
  final Map<String, PriceInfo> prices;

  TcgPlayer({required this.url, required this.updatedAt, required this.prices});

  factory TcgPlayer.fromJson(Map<String, dynamic> json) {
    final pricesMap = (json['prices'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(key, PriceInfo.fromJson(value)),
    );

    return TcgPlayer(
      url: json['url'],
      updatedAt: json['updatedAt'],
      prices: pricesMap,
    );
  }
}

class CardMarket {
  final String url;
  final String updatedAt;
  final Map<String, dynamic> prices;

  CardMarket({
    required this.url,
    required this.updatedAt,
    required this.prices,
  });

  factory CardMarket.fromJson(Map<String, dynamic> json) {
    return CardMarket(
      url: json['url'],
      updatedAt: json['updatedAt'],
      prices: Map<String, dynamic>.from(json['prices']),
    );
  }
}

class PriceInfo {
  final double? low;
  final double? mid;
  final double? high;
  final double? market;
  final double? directLow;

  PriceInfo({this.low, this.mid, this.high, this.market, this.directLow});

  factory PriceInfo.fromJson(Map<String, dynamic> json) {
    return PriceInfo(
      low: (json['low'] as num?)?.toDouble(),
      mid: (json['mid'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      market: (json['market'] as num?)?.toDouble(),
      directLow: (json['directLow'] as num?)?.toDouble(),
    );
  }
}
