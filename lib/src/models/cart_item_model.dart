// [TÓPICO 1: Arquitetura de Pastas] Importação correta do modelo de produto base dentro da mesma pasta src/models
import 'product_model.dart';

// [TÓPICO 3: Modelagem de Dados] Classe estrutural que define o formato de persistência temporária de um item no carrinho
class CartItemModel {
  final ProductModel product;
  int quantity;
  String size;
  String color;
  CartItemModel({
    required this.product,
    this.quantity = 1,
    required this.size,
    required this.color,
  });

  // [TÓPICO 12: Lógica de Carrinho] Propriedade computada encapsulada para cálculo atômico do subtotal da linha
  double get totalValue => product.price * quantity;
}
