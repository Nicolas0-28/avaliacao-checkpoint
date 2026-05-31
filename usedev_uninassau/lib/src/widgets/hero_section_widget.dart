import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// [TÓPICO 1: Componentização] Widget isolado para garantir alta coesão e responsabilidade única
class HeroSectionWidget extends StatelessWidget {
  const HeroSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // [TÓPICO 2: UI Declarativa] Uso de DecoratedBox para estilização visual com assets
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/banner_cta.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // [TÓPICO 3: Organização de Assets] Referenciando imagens locais organizadas
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset('assets/hero_cta.png', width: 300),
          ),

          // [TÓPICO 4: Tipografia Avançada] Utilizando Text.rich e GoogleFonts para identidade visual
          Text.rich(
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: GoogleFonts.orbitron().fontFamily,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
            const TextSpan(
              text: 'Hora de abraçar seu ',
              style: TextStyle(color: Color(0xFFFF55DF)),
              children: [
                TextSpan(
                  text: 'lado geek',
                  style: TextStyle(color: Color(0xFF8FFF24)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // [TÓPICO 5: Interatividade] Botão estilizado com feedback visual
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF780BF7),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            ),
            child: Text(
              'Ver as Novidades',
              style: TextStyle(
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
