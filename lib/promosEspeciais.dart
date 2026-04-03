import 'package:flutter/material.dart';

//Duplicado utilizado o codigo de categorias_page.dart

class PromocoesPage extends StatelessWidget {
  const PromocoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color corAzul = Color(0xFF0D0221);

    final List<Map<String, String>> produtos = [
      {
        'nome': 'Camiseta Capy',
        'preco': '28,00',
        'imagem': 'assets/images/capivara.png',
      },
      {
        'nome': 'Mousepad Café',
        'preco': '18,00',
        'imagem': 'assets/images/mousepad.png',
      },
      {
        'nome': 'Caneca Bug',
        'preco': '28,00',
        'imagem': 'assets/images/canecapreta.png',
      },
      {
        'nome': 'Boné 404',
        'preco': '25,00',
        'imagem': 'assets/images/boner.png',
      },
      {
        'nome': 'Quadro While',
        'preco': '22,00',
        'imagem': 'assets/images/quadro.png',
      },
      {
        'nome': 'Copo Dev',
        'preco': '28,00',
        'imagem': 'assets/images/copo.png',
      },
    ];

    //COLUNA
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 40, bottom: 20),
          child: Text(
            'Promos especiais',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: corAzul,
              fontFamily: 'FontesTitulo', // FONTE DE TÍTULO AQUI
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: produtos.length,
            itemBuilder: (context, i) => ProdutoCard(
              nome: produtos[i]['nome']!,
              preco: produtos[i]['preco']!,
              imagem: produtos[i]['imagem']!,
            ),
          ),
        ),
      ],
    );
  }
}
