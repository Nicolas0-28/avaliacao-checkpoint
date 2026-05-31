import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/screens/product_detail_screen.dart';

// [TÓPICO 11: Componentização de Widgets] Widget reutilizável para exibição de itens do catálogo
class ProductCardWidget extends StatelessWidget {
  // [TÓPICO 5: Data Binding] Recebe um modelo de dados para renderização dinâmica
  final ProductModel product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // [TÓPICO 12: Navegação e Rotas] Implementa transição entre a Vitrine e o Detalhe do Produto
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            // [TÓPICO 13: Integração de APIs] Exibição de imagem vinda de URL externa
            Expanded(child: Image.network(product.imageUrl, fit: BoxFit.cover)),

            // [TÓPICO 4: Estilização com GoogleFonts] Consistência visual com a marca
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                style: GoogleFonts.orbitron(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // [TÓPICO 5: Formatação de Dados] Conversão de double para String formatada em moeda
            Text(
              'R\$ ${product.price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(color: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
