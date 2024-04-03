

class Restaurant {
  int id;
  String name;
  Neighborhood neighborhood;
  String photograph;
  String address;
  Latlng latlng;
  String cuisineType;
  OperatingHours operatingHours;
  List<Review> reviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.neighborhood,
    required this.photograph,
    required this.address,
    required this.latlng,
    required this.cuisineType,
    required this.operatingHours,
    required this.reviews,
  });

  Restaurant copyWith({
    int? id,
    String? name,
    Neighborhood? neighborhood,
    String? photograph,
    String? address,
    Latlng? latlng,
    String? cuisineType,
    OperatingHours? operatingHours,
    List<Review>? reviews,
  }) =>
      Restaurant(
        id: id ?? this.id,
        name: name ?? this.name,
        neighborhood: neighborhood ?? this.neighborhood,
        photograph: photograph ?? this.photograph,
        address: address ?? this.address,
        latlng: latlng ?? this.latlng,
        cuisineType: cuisineType ?? this.cuisineType,
        operatingHours: operatingHours ?? this.operatingHours,
        reviews: reviews ?? this.reviews,
      );

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    neighborhood: neighborhoodValues.map[json["neighborhood"]]!,
    photograph: json["photograph"],
    address: json["address"],
    latlng: Latlng.fromJson(json["latlng"]),
    cuisineType: json["cuisine_type"],
    operatingHours: OperatingHours.fromJson(json["operating_hours"]),
    reviews:
    List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "neighborhood": neighborhoodValues.reverse[neighborhood],
    "photograph": photograph,
    "address": address,
    "latlng": latlng.toJson(),
    "cuisine_type": cuisineType,
    "operating_hours": operatingHours.toJson(),
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
  };
}

class Latlng {
  double lat;
  double lng;

  Latlng({
    required this.lat,
    required this.lng,
  });

  Latlng copyWith({
    double? lat,
    double? lng,
  }) =>
      Latlng(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Latlng.fromJson(Map<String, dynamic> json) => Latlng(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

// ignore: constant_identifier_names
enum Neighborhood { BROOKLYN, MANHATTAN, QUEENS }

final neighborhoodValues = EnumValues({
  "Brooklyn": Neighborhood.BROOKLYN,
  "Manhattan": Neighborhood.MANHATTAN,
  "Queens": Neighborhood.QUEENS
});

class OperatingHours {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  OperatingHours({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  OperatingHours copyWith({
    String? monday,
    String? tuesday,
    String? wednesday,
    String? thursday,
    String? friday,
    String? saturday,
    String? sunday,
  }) =>
      OperatingHours(
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
      );

  factory OperatingHours.fromJson(Map<String, dynamic> json) => OperatingHours(
    monday: json["Monday"],
    tuesday: json["Tuesday"],
    wednesday: json["Wednesday"],
    thursday: json["Thursday"],
    friday: json["Friday"],
    saturday: json["Saturday"],
    sunday: json["Sunday"],
  );

  Map<String, dynamic> toJson() => {
    "Monday": monday,
    "Tuesday": tuesday,
    "Wednesday": wednesday,
    "Thursday": thursday,
    "Friday": friday,
    "Saturday": saturday,
    "Sunday": sunday,
  };
}

class Review {
  String name;
  Date date;
  int rating;
  String comments;

  Review({
    required this.name,
    required this.date,
    required this.rating,
    required this.comments,
  });

  Review copyWith({
    String? name,
    Date? date,
    int? rating,
    String? comments,
  }) =>
      Review(
        name: name ?? this.name,
        date: date ?? this.date,
        rating: rating ?? this.rating,
        comments: comments ?? this.comments,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    name: json["name"],
    date: dateValues.map[json["date"]]!,
    rating: json["rating"],
    comments: json["comments"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "date": dateValues.reverse[date],
    "rating": rating,
    "comments": comments,
  };
}

enum Date { OCTOBER_262016 }

final dateValues = EnumValues({"October 26, 2016": Date.OCTOBER_262016});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}