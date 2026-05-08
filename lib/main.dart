import 'package:flutter/material.dart';
import 'detalhes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo de Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  List<Map<String, String>> filmes = [
    {
      "nome": "Como eu era antes de você",
      "imagem": "../images/filme1.jpg",
      "descricao": "Um romance emocionante sobre amor e superação.",
    },
    {
      "nome": "O badboy e eu",
      "imagem": "../images/filme2.jpg",
      "descricao": "Uma história de amor entre um badboy e uma garota doce.",
    },
    {
      "nome": "Wicked",
      "imagem": "../images/filme3.jpg",
      "descricao": "Um musical mágico que conta a história das bruxas de Oz.",
    },
    {
      "nome": "Viva a vida é uma festa",
      "imagem": "../images/filme4.jpg",
      "descricao": "Uma aventura musical que celebra a importância da família e das tradições.",
    },
    {
      "nome": "A empregada",
      "imagem": "../images/filme5.jpg",
      "descricao": "Um drama intenso sobre a luta por justiça e igualdade.",
    },
  ];

  Color corFundo = Colors.white;

  void adicionarFilme() {
    if (controller.text.isNotEmpty) {
      setState(() {
        filmes.add({
          "nome": controller.text,
          "imagem": "images/avatar.jpg",
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

  void alterarCor() {
    setState(() {
      if (corFundo == Colors.white) {
        corFundo = Colors.blue.shade100;
      } else if (corFundo == Colors.blue.shade100) {
        corFundo = Colors.green.shade100;
      } else {
        corFundo = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,

      appBar: AppBar(
        title: const Text("Catálogo de Filmes"),
        centerTitle: true,
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

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: alterarCor,
                child: const Text("Alterar Cor de Fundo"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filmes.length,

                itemBuilder: (context, index) {

                  return Card(
                    child: ListTile(

                      leading: Image.asset(
                        filmes[index]["imagem"]!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),

                      title: Text(
                        filmes[index]["nome"]!,
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
                              nomeFilme: filmes[index]["nome"]!,
                              imagemFilme: filmes[index]["imagem"]!,
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