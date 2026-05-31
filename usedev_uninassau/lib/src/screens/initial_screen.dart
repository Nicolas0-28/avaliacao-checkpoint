import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/services/product_service.dart';
// [TÓPICO 1: Arquitetura de Pastas] Importações modulares vindas das subpastas corretas
import 'package:usedev_uninassau/src/widgets/custom_app_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/hero_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/product_card_widget.dart';
import 'package:usedev_uninassau/src/widgets/subscription_section_widget.dart';

// [TÓPICO 10: Componentização de Telas] View principal que gerencia o estado do catálogo
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
    // [TÓPICO 2 & 5: Consumo de Serviço] Carregamento inicial assíncrono dos produtos
    _productsFuture = _productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      // [TÓPICO 10: Widgets Customizados] Uso da AppBar global
      appBar: const CustomAppBarWidget(),
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
                child: Text('Erro ao carregar catálogo: ${snapshot.error}'),
              ),
            );
          }

          final products = snapshot.data ?? [];
          final limitedProducts = products.take(4).toList();

          // [TÓPICO 15: Estrutura de Listagem] Organização dos seções do app
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
