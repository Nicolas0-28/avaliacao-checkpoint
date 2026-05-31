import 'package:flutter/material.dart';
// [TÓPICO 9: Interface com Google Fonts] Importação do pacote para estilização tipográfica padrão
import 'package:google_fonts/google_fonts.dart';
// [TÓPICO 1: Arquitetura de Pastas] Importações relativas apontando para as camadas corretas de src/
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/screens/cart_screen.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';
import 'package:usedev_uninassau/src/widgets/custom_app_bar_widget.dart';

// [TÓPICO 10: Componentização de Telas] StatefulWidget utilizado para gerenciar as mutações dos atributos locais
class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedColor = 'Bege';
  String _selectedSize = 'M';
  int _quantity = 1;

  // [TÓPICO 5: Padrão Singleton] Instância global do carrinho para dispatch dos dados
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: const CustomAppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do Produto com ajuste estético
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
              child: product.imageUrl.isNotEmpty
                  ? Image.network(product.imageUrl, fit: BoxFit.cover)
                  : const Icon(Icons.image, size: 100, color: Colors.grey),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: GoogleFonts.orbitron(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF090129),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R\$ ${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.orbitron(
                      fontSize: 20,
                      color: const Color(0xFF780BF7),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Seção de Seleção de Cor
                  Text(
                    'Escolha a cor',
                    style: GoogleFonts.orbitron(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: ['Bege', 'Branca', 'Cinza'].map((color) {
                      return ChoiceChip(
                        label: Text(color),
                        selected: _selectedColor == color,
                        selectedColor: const Color(0xFF780BF7),
                        labelStyle: TextStyle(
                          color: _selectedColor == color
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (selected) =>
                            setState(() => _selectedColor = color),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Seleção de Qtd e Tamanho
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          'Qtd',
                          _quantity,
                          List.generate(5, (i) => i + 1),
                          (val) => setState(() => _quantity = val!),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdown(
                          'Tam',
                          _selectedSize,
                          ['P', 'M', 'G', 'GG'],
                          (val) => setState(() => _selectedSize = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // [TÓPICO 12: Despacho de Regra de Negócio] Gatilho de persistência
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _cartService.addToCart(
                          product: widget.product,
                          size: _selectedSize,
                          color: _selectedColor,
                          quantity: _quantity,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.product.title} adicionado!',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_checkout),
                      label: const Text('Adicionar ao carrinho'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF780BF7),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para dropdowns para manter o código limpo
  Widget _buildDropdown(
    String label,
    dynamic value,
    List<dynamic> items,
    Function(dynamic) onChanged,
  ) {
    return DropdownButtonFormField<dynamic>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
      ),
      items: items
          .map((i) => DropdownMenuItem(value: i, child: Text(i.toString())))
          .toList(),
      onChanged: onChanged,
    );
  }
}
