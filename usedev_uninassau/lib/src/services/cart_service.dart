import 'package:flutter/material.dart';

// [TÓPICO 1: Arquitetura de Pastas] Importação correta dos modelos de dados dentro de src/models/
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

// [TÓPICO 4 & 5] Gerenciamento de Estado Nativo com ChangeNotifier e Instância Única Global (Singleton)
class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  // Coleção encapsulada interna dos itens alocados
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  // [TÓPICO 12: Regras de Negócio e Cálculos Centralizados]

  double get subtotal {
    return _items.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  double get frete => _items.isEmpty ? 0.0 : 8.0;

  double get total => subtotal + frete;

  // [TÓPICO 12] Adicionar item gerenciando duplicações e fusões por ID, tamanho e cor
  void addToCart({
    required ProductModel product,
    required String size,
    required String color,
    required int quantity,
  }) {
    final index = _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.size == size &&
          item.color == color,
    );

    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItemModel(
          product: product,
          size: size,
          color: color,
          quantity: quantity,
        ),
      );
    }
    notifyListeners(); // [TÓPICO 4] Notifica a árvore de Widgets (como as Badges e a CartScreen)
  }

  // [TÓPICO 12] Atualização dinâmica de tamanhos direto pela listagem do carrinho
  void updateItemSize(CartItemModel item, String newSize) {
    final duplicateIndex = _items.indexWhere(
      (element) =>
          element != item &&
          element.product.id == item.product.id &&
          element.color == item.color &&
          element.size == newSize,
    );

    if (duplicateIndex >= 0) {
      _items[duplicateIndex].quantity += item.quantity;
      _items.remove(item);
    } else {
      item.size = newSize;
    }

    notifyListeners(); // [TÓPICO 4] Atualiza a UI de forma síncrona e reativa
  }

  // [TÓPICO 12] Funções utilitárias de controle incremental de estado reativo
  void incrementQuantity(CartItemModel item) {
    item.quantity++;
    notifyListeners();
  }

  void decrementQuantity(CartItemModel item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void removeItem(CartItemModel item) {
    _items.remove(item);
    notifyListeners();
  }
}
