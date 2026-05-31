import 'package:flutter/material.dart';
// [TÓPICO 9: Interface com Google Fonts] Importação do pacote para padronização tipográfica da UI
import 'package:google_fonts/google_fonts.dart';

// [TÓPICO 1: Arquitetura de Pastas] Importações relativas apontando para as camadas corretas de modelos e serviços
import '../models/cart_item_model.dart';
import '../services/cart_service.dart';

// [TÓPICO 10: Componentização de Telas] View isolada para gerenciamento e revisão de compras do usuário
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // [TÓPICO 5: Padrão Singleton] Acessando a instância unificada em memória do carrinho
    final cartService = CartService();

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text(
          'Carrinho de Compras',
          style: GoogleFonts.orbitron(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          // [TÓPICO 8: Navegação] Retorno simples desempilhando a tela atual
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // [TÓPICO 4: Estado Reativo Simples] ListenableBuilder reconstrói a árvore interna a cada notifyListeners() do serviço
      body: ListenableBuilder(
        listenable: cartService,
        builder: (context, child) {
          final cartItems = cartService.items;
          if (cartItems.isEmpty) {
            return Center(
              child: Text(
                'Seu carrinho está vazio.',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvisoReserva(),
                const SizedBox(height: 20),
                Text(
                  'Detalhes da compra',
                  style: GoogleFonts.orbitron(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // [TÓPICO 11: Exibição de Listas Dinâmicas] Mapeamento reativo da coleção de modelos do carrinho
                ...cartItems.map((item) => _buildItemCard(item, cartService)),
                const SizedBox(height: 24),
                // [TÓPICO 12: Sumário Computado] Bloco contendo os cálculos consolidados
                _buildSumarioCard(context, cartService),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvisoReserva() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFDCE4EC),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        const Icon(Icons.info, size: 20, color: Colors.indigo),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Atenção, os produtos no carrinho não ficam reservados. Finalize a compra para garantir! :)',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
  Widget _buildItemCard(CartItemModel item, CartService service) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        // Imagem do Produto [TÓPICO 15]
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: item.product.imageUrl.isNotEmpty
              ? Image.network(item.product.imageUrl, fit: BoxFit.contain)
              : const Icon(Icons.image, color: Colors.grey),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.title,
                style: GoogleFonts.orbitron(
                  fontSize: 14,
                  color: const Color(0xFF090129),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                '${item.product.description}\nCor: ${item.color}',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 11,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'R\$ ${item.product.price.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: const Color(0xFF780BF7),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),

        // Controles de quantidade e atributos variáveis
        Column(
          children: [
            Text(
              'Qtd:',
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.black54),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, size: 18),
                  onPressed: () => service.decrementQuantity(item),
                ),
                Text(
                  '${item.quantity}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  onPressed: () => service.incrementQuantity(item),
                ),
              ],
            ),

            DropdownButton<String>(
              value: item.size,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87),
              underline: const SizedBox(),
              items: [
                'P',
                'M',
                'G',
                'GG',
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) =>
                  val != null ? service.updateItemSize(item, val) : null,
            ),
          ],
        ),
        // Remoção imediata da linha
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.black54),
          onPressed: () => service.removeItem(item),
        ),
      ],
    ),
  );

  // Card do fechamento de valores agregados [TÓPICO 12]
  Widget _buildSumarioCard(
    BuildContext context,
    CartService service,
  ) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sumário',
          style: GoogleFonts.orbitron(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildLinhaInput(label: 'Cupom de desconto', hint: 'Digite o cupom'),
        const SizedBox(height: 12),
        _buildLinhaInput(label: 'Frete', hint: 'Digite o CEP'),
        const SizedBox(height: 16),
        const Divider(color: Colors.purple, thickness: 0.5),

        _buildLinhaValores(
          '${service.items.length.toString().padLeft(2, '0')} Produtos',
          'R\$ ${service.subtotal.toStringAsFixed(2)}',
        ),
        const SizedBox(height: 8),
        _buildLinhaValores('Frete', 'R\$ ${service.frete.toStringAsFixed(2)}'),
        const Divider(color: Colors.purple, thickness: 0.5),
        _buildLinhaValores(
          'Total:',
          'R\$ ${service.total.toStringAsFixed(2)}',
          true,
        ),
        const SizedBox(height: 24),
        _buildBotaoAction(
          'Continuar comprando',
          () => Navigator.pop(context),
          isPrimary: false,
        ),
        const SizedBox(height: 12),
        _buildBotaoAction('Ir para pagamento', () {}),
      ],
    ),
  );

  Widget _buildLinhaInput({
    required String label,
    required String hint,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 6),
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 36,
              child: TextField(
                style: GoogleFonts.poppins(fontSize: 13),
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  filled: true,
                  fillColor: const Color(0xFFF0F0F0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9C27B0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Ok',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _buildLinhaValores(
    String label,
    String valor, [
    bool isTotal = false,
  ]) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: isTotal
            ? GoogleFonts.orbitron(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF9C27B0),
              )
            : GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
      ),
      Text(
        valor,
        style: isTotal
            ? GoogleFonts.orbitron(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF9C27B0),
              )
            : GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
      ),
    ],
  );

  Widget _buildBotaoAction(
    String label,
    VoidCallback onPressed, {
    bool isPrimary = true,
  }) => SizedBox(
    width: double.infinity,
    height: 44,
    child: isPrimary
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9C27B0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.purple, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
  );
}
