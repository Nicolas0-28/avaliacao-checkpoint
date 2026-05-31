import 'dart:convert';

// [TÓPICO 2: Consumo de API REST] Importação do pacote oficial HTTP para comunicação assíncrona externa
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

// [TÓPICO 1: Separação de Conceitos (SoC)] Classe especialista encarregada da infraestrutura de dados do catálogo
class ProductService {
  // [TÓPICO 2] Método assíncrono que realiza a requisição GET e retorna a lista tipada de produtos
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      if (response.statusCode == 200) {
        // Realiza o parse inicial da String JSON recebida para uma lista dinâmica
        final List<dynamic> jsonData = json.decode(response.body);

        // [TÓPICO 3: Modelagem e Desserialização] Mapeamento e transformação dos dados brutos
        return jsonData.map((item) {
          final Map<String, dynamic> moddedItem = Map<String, dynamic>.from(
            item,
          );

          final int id = moddedItem['id'] as int;

          switch (id) {
            case 1:
              moddedItem['description'] =
                  "Sua mochila perfeita para o uso diário e caminhadas. Possui compartimento acolchoado para notebooks de até 15 polegadas e tecido resistente.";
              break;
            case 2:
              moddedItem['description'] =
                  "Camiseta casual com ajuste slim fit moderno. Tecido leve, confortável e perfeito para qualquer ocasião do seu dia a dia.";
              break;
            case 3:
              moddedItem['description'] =
                  "Jaqueta de algodão premium com estilo urbano. Ideal para dias frios, combinando conforto com bolsos utilitários práticos.";
              break;
            case 4:
              moddedItem['description'] =
                  "Camiseta masculina casual de manga curta, feita com algodão macio e respirável de alta durabilidade.";
              break;
            case 5:
              moddedItem['description'] =
                  "Pulseira de corrente elegante em estilo clássico, feita de aço inoxidável polido de alta resistência.";
              break;
            default:
              break;
          }

          return ProductModel.fromJson(moddedItem);
        }).toList();
      } else {
        throw Exception('Falha ao carregar os produtos do servidor.');
      }
    } catch (e) {
      // [TÓPICO 14: Tratamento de Erros] Captura falhas físicas de rede e lança mensagem tratada para a UI
      throw Exception('Erro de conexão: Verifique sua internet.');
    }
  }
}
