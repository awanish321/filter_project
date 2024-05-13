class Location {
  int? id;
  String? city;
  String? cityHindi;
  int? stateId;
  String? state;
  String? stateHindi;
  String? country;
  String? countryHindi;
  int? countryId;

  Location(
      {this.id,
        this.city,
        this.cityHindi,
        this.stateId,
        this.state,
        this.stateHindi,
        this.country,
        this.countryHindi,
        this.countryId});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    cityHindi = json['cityHindi'];
    stateId = json['state_id'];
    state = json['state'];
    stateHindi = json['stateHindi'];
    country = json['country'];
    countryHindi = json['countryHindi'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    data['cityHindi'] = cityHindi;
    data['state_id'] = stateId;
    data['state'] = state;
    data['stateHindi'] = stateHindi;
    data['country'] = country;
    data['countryHindi'] = countryHindi;
    data['country_id'] = countryId;
    return data;
  }
}
