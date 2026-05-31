import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// [TÓPICO 4: Gerenciamento de Estado Nativo] O uso do ChangeNotifier permite que a UI escute as mudanças de carregamento e login
class AuthService extends ChangeNotifier {
  // [TÓPICO 5: Padrão Design Singleton] Garante uma única instância do serviço gerenciando o Token em toda a vida útil do app
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _token;
  bool _isLoading = false;

  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;

  // [TÓPICO 2 & 6: Requisições POST e Autenticação Método assíncrono para validação de credenciais na FakeStoreAPI

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token =
            data['token']; // [TÓPICO 6] Captura e armazena o token JWT de acesso

        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      // [TÓPICO 14: Tratamento de Erros] Evita falha crítica no app em caso de perda de conexão física
      debugPrint('Erro de autenticação no Service: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
