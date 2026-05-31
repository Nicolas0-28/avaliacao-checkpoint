import 'package:flutter/material.dart';
// [TÓPICO 9: Interface com Google Fonts] Importação do pacote para estilização tipográfica padrão
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/widgets/custom_app_bar_widget.dart';

// [TÓPICO 1: Arquitetura de Pastas] Importações relativas apontando para as camadas corretas de src/
import '../models/product_model.dart';
import '../services/cart_service.dart';
import 'cart_screen.dart';

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
      // [TÓPICO 10] Reutilização da barra superior customizada
      appBar: const CustomAppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 320,
              width: double.infinity,
              color: const Color(0xFFF5F5F5),
              child: product.imageUrl.isNotEmpty
                  ? Image.network(product.imageUrl, fit: BoxFit.contain)
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF090129),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'R\$ ${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.orbitron(
                      fontSize: 20,
                      color: const Color(0xFF780BF7), // Roxo da paleta UseDev
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    product.description,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Escolha a cor do tecido',
                    style: GoogleFonts.orbitron(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: const Color(0xFF090129),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Column(
                    children: ['Bege', 'Branca', 'Cinza'].map((color) {
                      return RadioListTile<String>(
                        title: Text(
                          color,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: color,
                        groupValue: _selectedColor,
                        activeColor: const Color(0xFF780BF7),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        onChanged: (value) {
                          setState(() {
                            _selectedColor = value ?? 'Bege';
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _quantity,
                          decoration: InputDecoration(
                            labelText: 'Quantidade',
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          items: List.generate(5, (index) => index + 1).map((
                            q,
                          ) {
                            return DropdownMenuItem(
                              value: q,
                              child: Text(q.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _quantity = value ?? 1;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedSize,
                          decoration: InputDecoration(
                            labelText: 'Tamanho',
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          items: ['P', 'M', 'G', 'GG'].map((size) {
                            return DropdownMenuItem(
                              value: size,
                              child: Text(size),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedSize = value ?? 'M';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // [TÓPICO 12: Despacho de Regra de Negócio] Gatilho de persistência no carrinho
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _cartService.addToCart(
                          product: widget.product,
                          size: _selectedSize,
                          color: _selectedColor,
                          quantity: _quantity,
                        );
                        // [TÓPICO 13: Feedback Nativo] SnackBar confirmação visual de sucesso
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.product.title} adicionado!',
                              style: GoogleFonts.poppins(),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // [TÓPICO 8: Navegação de Fluxo] Transiciona o usuário imediatamente para o carrinho
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_checkout, size: 20),
                      label: Text(
                        'Adicionar ao carrinho',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C27B0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
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
}
