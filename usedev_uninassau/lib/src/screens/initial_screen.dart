import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/widgets/custom_app_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/hero_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/product_card_widget.dart';
import 'package:usedev_uninassau/src/widgets/subscription_section_widget.dart';

// [TÓPICO 1: Arquitetura de Pastas] Importações modulares organizadas por escopo dentro de src/
import '../models/product_model.dart';
import '../services/product_service.dart';

// [TÓPICO 10: Componentização de Telas] View principal representativa da Vitrine da loja UseDev
class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final ProductService _productService = ProductService();
  late Future<List<ProductModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    // [TÓPICO 2 & 14] Dispara a requisição HTTP da API apenas UMA vez no ciclo de vida inicial da tela
    _productsFuture = _productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      // [TÓPICO 10] Uso do componente de AppBar personalizado e reutilizável
      appBar: const CustomAppBarWidget(),
      // [TÓPICO 14: Tratamento de Estados] FutureBuilder gerencia de forma limpa os estados assíncronos da UI
      body: FutureBuilder<List<ProductModel>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Erro ao carregar catálogo: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text('Nenhum produto localizado no momento.'),
            );
          }

          final limitedProducts = products.take(4).toList();

          return ListView(
            children: [
              const HeroSectionWidget(),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: limitedProducts.length,
                  // [TÓPICO 11: Listas Dinâmicas] GridView monta dinamicamente os cards baseados na API REST
                  itemBuilder: (context, index) {
                    return ProductCardWidget(product: limitedProducts[index]);
                  },
                ),
              ),

              const SubscriptionSectionWidget(),
            ],
          );
        },
      ),
    );
  }
}
