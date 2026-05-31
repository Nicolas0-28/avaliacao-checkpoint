import 'package:flutter/material.dart';
// [TÓPICO 9: Interface com Google Fonts] Importação do pacote para aplicação de tipografias específicas da marca
import 'package:google_fonts/google_fonts.dart';

// [TÓPICO 10: Widgets Customizados] Componente isolado e reutilizável para a seção de captura (Newsletter) na base da Vitrine
class SubscriptionSectionWidget extends StatelessWidget {
  const SubscriptionSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFF8FFF24)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            Text(
              'Inscreva-se para ganhar descontos!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                // [TÓPICO 9] Aplicação da fonte Orbitron estruturando o título chamativo e imponente
                fontFamily: GoogleFonts.orbitron().fontFamily,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Cadastre seu email, receba novidades e descontos imperdíveis antes de todo mundo!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                // [TÓPICO 9] Uso da fonte Poppins garantindo excelente leitura para blocos de texto maiores
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Digite seu melhor endereço de email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF780BF7),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Inscrever',
                style: TextStyle(
                  // [TÓPICO 9] Tipografia de apoio mantendo a consistência visual no botão
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
