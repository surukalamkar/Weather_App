class WeatherModel {
  Location? location;
  Current? current;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['location'] != null) {
      location = Location.fromJson(json['location']);
    } else {
      location = null;
    }
    if (json['current'] != null) {
      current = Current.fromJson(json['current']);
    } else {
      current = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? localtime;

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['region'] = region;
    data['country'] = country;
    data['lat'] = lat;
    data['lon'] = lon;
    data['localtime'] = localtime;
    return data;
  }
}

class Current {
  double? tempC;
  Condition? condition;


  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];

    if (json['condition'] != null) {
      condition = Condition.fromJson(json['condition']);
    } else {
      condition = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['temp_c'] = tempC;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    return data;
  }
}

class Condition {
  String? text;
  String? icon;

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['text'] = text;
    data['icon'] = icon;
    return data;
  }
}
