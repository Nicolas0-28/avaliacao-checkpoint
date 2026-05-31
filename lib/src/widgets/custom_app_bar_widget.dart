import 'package:flutter/material.dart';

// [TÓPICO 1: Arquitetura de Pastas] Importações modulares relativas apontando para as telas e serviços dentro de src/
import '../../../usedev_uninassau/lib/src/screens/cart_screen.dart';
import '../../../usedev_uninassau/lib/src/screens/login_screen.dart';
import '../../../usedev_uninassau/lib/src/services/cart_service.dart';

// [TÓPICO 10: Widgets Customizados] Componente global reutilizável para padronização da barra de navegação superior
class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // [TÓPICO 5: Padrão Design Singleton] Acessando a instância unificada do carrinho em memória
    final CartService cartService = CartService();

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {},
      ),
      // [TÓPICO 15: Gerenciamento de Assets] Renderização da logo local do projeto cadastrada no pubspec.yaml
      title: Image.asset('assets/logo_usedev.png', height: 40),
      centerTitle: true,
      actions: [
        // Atalho de perfil e autenticação
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.black),
          // [TÓPICO 8: Navegação] Redirecionamento linear para a tela de Login
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),

        // [TÓPICO 4: Estado Reativo Nativo]
        ListenableBuilder(
          listenable: cartService,
          builder: (context, child) {
            // Conta a quantidade total de linhas/itens alocados no carrinho global [TÓPICO 12]
            final int totalItens = cartService.items.length;

            return Badge(
              label: Text(totalItens.toString()),
              isLabelVisible: totalItens > 0,
              backgroundColor: Colors.purple,
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
                // [TÓPICO 8: Navegação] Redirecionamento para a tela de revisão de compras
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // [TÓPICO 10] Define a altura física padrão reservada para a renderização deste componente customizado
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
