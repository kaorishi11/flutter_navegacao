import 'package:flutter/material.dart';
import 'detalhes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool temaEscuro = false;

  void alterarTema() {
    setState(() {
      temaEscuro = !temaEscuro;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Catálogo de Filmes',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      themeMode: temaEscuro
          ? ThemeMode.dark
          : ThemeMode.light,

      home: HomePage(
        alterarTema: alterarTema,
      ),
    );
  }
}

class HomePage extends StatefulWidget {

  final VoidCallback alterarTema;

  const HomePage({
    super.key,
    required this.alterarTema,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController controller = TextEditingController();

  List<Map<String, String>> filmes = [
    {
      "nome": "Como eu era antes de você",
      "imagem": "../images/filme1.jpg",
      "descricao":
      "Um romance emocionante sobre amor, escolhas e superação.",
    },
    {
      "nome": "O badboy e eu",
      "imagem": "../images/filme2.jpg",
      "descricao":
      "Uma história de amor entre um badboy rebelde e uma garota doce.",
    },
    {
      "nome": "Wicked",
      "imagem": "../images/filme3.jpg",
      "descricao":
      "Um musical mágico que mostra a verdadeira história das bruxas de Oz.",
    },
    {
      "nome": "Viva a vida é uma festa",
      "imagem": "../images/filme4.jpg",
      "descricao":
      "Uma aventura musical emocionante sobre família e tradições.",
    },
    {
      "nome": "A empregada",
      "imagem": "../images/filme5.jpg",
      "descricao":
      "Um drama intenso sobre desigualdade, justiça e sobrevivência.",
    },
  ];

  void adicionarFilme() {

    if (controller.text.isNotEmpty) {
      setState(() {
        filmes.add({
          "nome": controller.text,
          "imagem": "images/filme1.jpg",
          "descricao": "Descrição adicionada automaticamente.",
        });
      });

      controller.clear();
    }
  }

  void removerFilme(int index) {

    setState(() {
      filmes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Catálogo de Filmes"),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: widget.alterarTema,
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Digite o nome do filme",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: adicionarFilme,
                child: const Text("Adicionar Filme"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filmes.length,
                itemBuilder: (context, index) {

                  return Card(
                    child: ListTile(

                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),

                        child: Image.asset(
                          filmes[index]["imagem"]!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),

                      title: Text(
                        filmes[index]["nome"]!,
                      ),

                      subtitle: Text(
                        filmes[index]["descricao"]!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      trailing: IconButton(

                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),

                        onPressed: () {
                          removerFilme(index);
                        },
                      ),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalhesPage(
                              nomeFilme:
                              filmes[index]["nome"]!,

                              imagemFilme:
                              filmes[index]["imagem"]!,

                              descricaoFilme:
                              filmes[index]["descricao"]!,
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