import 'package:avaliacao_08/models/character_model.dart';
import 'package:avaliacao_08/services/characters_service.dart';
import 'package:avaliacao_08/views/characters/character_card.dart';
import 'package:flutter/material.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  List<CharacterModel> characters = [];
  bool isLoading = true;
  String errorMessage = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCharacters();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getCharacters() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final CharactersService charactersService = CharactersService();
    try {
      List<CharacterModel> charactersList = await charactersService
          .getCharacters();
      setState(() {
        characters = charactersList;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Erro ao carregar personagens: $e';
      });
      return;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personagens de Demon Slayer',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[700],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 20),
            Text('Carregando personagens...', style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getCharacters,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
              ),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (characters.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum personagem encontrado',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: getCharacters,
      color: Colors.red,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          return CharacterCard(character: character);
        },
      ),
    );
  }
}
