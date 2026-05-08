import 'package:flutter/material.dart';
import 'detalhes.dart';
import 'filme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaPrincipal(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  final List<Filme> _filmes = [];

  Color _corFundo = Colors.white;

  void _adicionarFilme() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _filmes.add(
          Filme(
            nome: _controller.text,
            imagemUrl:
                _urlController.text.isNotEmpty
                    ? _urlController.text
                    : null,
          ),
        );

        _controller.clear();
        _urlController.clear();
      });
    }
  }

  void _removerFilme(int index) {
    setState(() {
      _filmes.removeAt(index);
    });
  }

  void _alterarCorFundo() {
    setState(() {
      _corFundo =
          _corFundo == Colors.white
              ? Colors.blue[50]!
              : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: AppBar(
        title: const Text('Catálogo de Filmes'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nome do filme',
                hintText: 'Ex: Vingadores',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.movie),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'URL da imagem',
                hintText: 'https://...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.image),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _adicionarFilme,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar'),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _alterarCorFundo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: const Icon(Icons.color_lens),
                    label: const Text('Cor'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child:
                  _filmes.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.movie_filter,
                              size: 64,
                              color: Colors.grey[400],
                            ),

                            const SizedBox(height: 16),

                            Text(
                              'Nenhum filme cadastrado',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: _filmes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            elevation: 3,
                            child: ListTile(
                              leading:
                                  _filmes[index].imagemUrl != null
                                      ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        child: Image.network(
                                          _filmes[index].imagemUrl!,
                                          width: 50,
                                          height: 70,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Container(
                                                  width: 50,
                                                  height: 70,
                                                  color: Colors.grey[300],
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                  ),
                                                );
                                              },
                                        ),
                                      )
                                      : Container(
                                        width: 50,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[100],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.movie,
                                          color: Colors.blue[400],
                                        ),
                                      ),

                              title: Text(
                                _filmes[index].nome,
                              ),

                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed:
                                    () => _removerFilme(index),
                              ),

                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => TelaDetalhes(
                                          filme: _filmes[index],
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}