import 'package:flutter/material.dart';

class AreaVerde extends StatelessWidget {
  const AreaVerde({super.key});

  @override
  Widget build(BuildContext context) {
    const Color corVerdeLimao = Color(0xFF99FF33);
    const Color corRoxa = Color(0xFF7B2CBF);
    const Color corTextoEscuro = Color(0xFF0D0221);

    return Container(
      width: double.infinity,
      color: corVerdeLimao,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min, //ESPAÇO DE AJUSTE
        children: [
          const SizedBox(height: 60),
          const Text(
            'Inscreva-se para ganhar descontos!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: corTextoEscuro,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Cadastre seu email, receba novidades e descontos imperdíveis antes de todo mundo!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: corTextoEscuro, height: 1.2),
          ),
          const SizedBox(height: 40),

          TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'Digite seu melhor endereço de email',
              hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Botão
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: corRoxa,
              foregroundColor: Colors.white,
              minimumSize: const Size(180, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Inscrever',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
