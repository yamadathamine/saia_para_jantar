class Item {
  String restaurante;
  String nomeDoPrato;
  String preco;
  String descricao;
  String foto;

  Item(
      {this.restaurante, this.nomeDoPrato, this.preco, this.descricao, this.foto});

  Item.fromJson(Map<String, dynamic> json) {
    restaurante = json['Restaurante'];
    nomeDoPrato = json['Nome do prato'];
    preco = json['Preço'];
    descricao = json['Descrição'];
    foto = json['Foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Restaurante'] = this.restaurante;
    data['Nome do prato'] = this.nomeDoPrato;
    data['Preço'] = this.preco;
    data['Descrição'] = this.descricao;
    data['Foto'] = this.foto;
    return data;
  }
}