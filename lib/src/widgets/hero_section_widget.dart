import 'package:flutter/material.dart';
// [TÓPICO 9: Interface com Google Fonts] Importação do pacote para aplicação de tipografias específicas
import 'package:google_fonts/google_fonts.dart';

// [TÓPICO 10: Widgets Customizados] Componente isolado para a seção de destaque (Hero/Banner) da Vitrine Inicial
class HeroSectionWidget extends StatelessWidget {
  const HeroSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      // [TÓPICO 15: Gerenciamento de Assets] Definição do banner de fundo decorativo carregado localmente
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/banner_cta.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(20),
            // [TÓPICO 15] Renderização da imagem principal de chamada
            child: Image.asset('assets/hero_cta.png', width: 300),
          ),

          const SizedBox(height: 20),
          Text.rich(
            textAlign: TextAlign.center,
            style: TextStyle(
              // [TÓPICO 9] Aplicação da fonte Orbitron para dar o aspecto tecnológico/geek
              fontFamily: GoogleFonts.orbitron().fontFamily,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
            TextSpan(
              text: 'Hora de abraçar seu ',
              style: const TextStyle(color: Color(0xFFFF55DF)),
              children: const [
                TextSpan(
                  text: 'lado geek',
                  style: TextStyle(color: Color(0xFF8FFF24)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF780BF7),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            ),
            child: Text(
              'Ver as Novidades',
              style: TextStyle(
                // [TÓPICO 9] Uso da fonte Poppins para melhor legibilidade no corpo de botões e textos
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
