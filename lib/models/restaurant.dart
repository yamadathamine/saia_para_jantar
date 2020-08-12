class Restaurant {
  String restaurante;

  Restaurant({this.restaurante});

  Restaurant.fromJson(Map<String, dynamic> json) {
    restaurante = json['Restaurante'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Restaurante'] = this.restaurante;
    return data;
  }
}