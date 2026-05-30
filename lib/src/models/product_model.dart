// [TÓPICO 1: Arquitetura de Pastas] Isolado dentro de src/models/ garantindo a separação de conceitos (SoC)
class ProductModel {
  // [TÓPICO 2: Imutabilidade] Atributos estritos definidos como final para consistência de dados
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  // [TÓPICO 3: Modelagem de Dados] Construtor Factory para desserializar o JSON bruto da FakeStoreAPI
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }
}
