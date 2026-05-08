import 'package:flutter/material.dart';

class DetalhesPage extends StatelessWidget {

  final String nomeFilme;
  final String imagemFilme;

  const DetalhesPage({
    super.key,
    required this.nomeFilme,
    required this.imagemFilme,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detalhes do Filme"),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Image.asset(
                imagemFilme,
                height: 250,
              ),

              const SizedBox(height: 20),

              Text(
                nomeFilme,

                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text("Voltar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}