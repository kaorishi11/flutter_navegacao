import 'package:flutter/material.dart';
import 'filme.dart';

class TelaDetalhes extends StatelessWidget {
  final Filme filme;

  const TelaDetalhes({
    super.key,
    required this.filme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Filme'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child:
                    filme.imagemUrl != null
                        ? Image.network(
                          filme.imagemUrl!,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                        : Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.blue[100],
                          child: Icon(
                            Icons.movie,
                            size: 80,
                            color: Colors.blue[400],
                          ),
                        ),
              ),

              const SizedBox(height: 24),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Nome do Filme',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        filme.nome,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Este é um filme incrível!',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),

                icon: const Icon(Icons.arrow_back),

                label: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}