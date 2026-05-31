import 'package:flutter/material.dart';
// [TÓPICO 9: Interface com Google Fonts] Importação para aplicação rigorosa da identidade tipográfica
import 'package:google_fonts/google_fonts.dart';

// [TÓPICO 1: Arquitetura de Pastas] Importação correta dos modelos e telas de dentro da estrutura src/
import '../../../usedev_uninassau/lib/src/models/product_model.dart';
import '../../../usedev_uninassau/lib/src/screens/product_detail_screen.dart';

// [TÓPICO 10: Widgets Customizados] Card individualizado e reutilizável para a exibição de produtos na Vitrine
class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // [TÓPICO 8: Navegação entre Telas] Transita para a tela de detalhes injetando o modelo do produto selecionado
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.contain,
                    // [TÓPICO 14: Abordagem Defensiva] Trata falhas de carregamento de mídia externa de forma amigável
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // [TÓPICO 9] Título forçado na fonte Orbitron (Estilo Técnico/Geek da marca UseDev)
                  // [TÓPICO 11] maxLines e ellipsis previnem estouro de pixels na renderização do Grid
                  Text(
                    product.title,
                    style: GoogleFonts.orbitron(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: const Color(
                        0xFF090129,
                      ), // Azul escuro profundo institucional
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),

                  // [TÓPICO 9] Descrição simplificada utilizando a fonte de apoio Poppins
                  Text(
                    product.description,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // [TÓPICO 9] Formatação monetária do preço em negrito de alta legibilidade
                  Text(
                    'R\$ ${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF780BF7),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
