import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/authorization/presentation/blocs/token_bloc.dart';

class TokenTestScreen extends StatelessWidget {
  const TokenTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TokenBloc>(
      create: (context) => getIt<TokenBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Тест получения токена'),
          backgroundColor: const Color(0xFF75D0FF),
        ),
        body: const TokenTestContent(),
      ),
    );
  }
}

class TokenTestContent extends StatefulWidget {
  const TokenTestContent({super.key});

  @override
  State<TokenTestContent> createState() => _TokenTestContentState();
}

class _TokenTestContentState extends State<TokenTestContent> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // При инициализации проверяем существующий токен
    context.read<TokenBloc>().add(CheckTokenEvent());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _getToken() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите username и пароль')),
      );
      return;
    }

    context.read<TokenBloc>().add(
      GetTokenEvent(username: username, password: password),
    );
  }

  void _checkToken() {
    context.read<TokenBloc>().add(CheckTokenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Поля ввода
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'username',
              border: OutlineInputBorder(),
              hintText: 'Введите ваш username',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Пароль',
              border: OutlineInputBorder(),
              hintText: 'Введите ваш пароль',
            ),
          ),
          const SizedBox(height: 20),

          // Кнопки действий
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _getToken,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Получить токен'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _checkToken,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Проверить токен'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Блок с состоянием и результатами
          Expanded(
            child: BlocBuilder<TokenBloc, TokenState>(
              builder: (context, state) {
                return _buildStateContent(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateContent(TokenState state) {
    if (state is TokenInitial) {
      return const Center(child: Text('Введите данные для получения токена'));
    } else if (state is TokenLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Загрузка...'),
          ],
        ),
      );
    } else if (state is TokenSuccess) {
      return _buildSuccessContent(state);
    } else if (state is TokenError) {
      return _buildErrorContent(state);
    } else if (state is TokenNotExists) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning, size: 64, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Токен не найден',
              style: TextStyle(fontSize: 18, color: Colors.orange),
            ),
            SizedBox(height: 8),
            Text(
              'Получите новый токен, введя username и пароль',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      return const Center(child: Text('Неизвестное состояние'));
    }
  }

  Widget _buildSuccessContent(TokenSuccess state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text(
                'Токен успешно получен!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Access Token
          const Text(
            'Access Token:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: SelectableText(
              state.accessToken,
              style: const TextStyle(fontFamily: 'Monospace', fontSize: 12),
            ),
          ),
          const SizedBox(height: 16),

          // Refresh Token
          const Text(
            'Refresh Token:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: SelectableText(
              state.refreshToken,
              style: const TextStyle(fontFamily: 'Monospace', fontSize: 12),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildErrorContent(TokenError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Ошибка получения токена',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red),
            ),
            child: SelectableText(
              state.error,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _checkToken,
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    );
  }
}
