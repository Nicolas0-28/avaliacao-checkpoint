import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// [TÓPICO 10: Componentização de UI] Widget dedicado à captura de dados do usuário (Newsletter)
class SubscriptionSectionWidget extends StatelessWidget {
  const SubscriptionSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // [TÓPICO 2: Layout e Estilização] Uso de DecoratedBox para delimitar a área da seção
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFF8FFF24)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // [TÓPICO 4: Tipografia e Identidade Visual] Títulos com fonte Orbitron
            Text(
              'Inscreva-se para ganhar descontos!',
              textAlign: TextAlign.center, // Corrigido
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.orbitron().fontFamily,
              ),
            ),
            const SizedBox(
              height: 20,
            ), // Substituído 'spacing' por SizedBox para compatibilidade total

            Text(
              'Cadastre seu email, receba novidades e descontos imperdíveis antes de todo mundo!',
              textAlign: TextAlign.center, // Corrigido
              style: TextStyle(
                fontSize: 18,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            const SizedBox(height: 20),

            // [TÓPICO 15: Formulários e Input] Implementação de campo de entrada de dados otimizado
            TextField(
              keyboardType: TextInputType.emailAddress, // Corrigido
              decoration: InputDecoration(
                hintText: 'Digite seu melhor endereço de email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // [TÓPICO 5: Interatividade] Botão de ação (Call to Action)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF780BF7),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ), // Corrigido
              ),
              child: Text(
                'Inscrever',
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
