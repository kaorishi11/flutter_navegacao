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
      "descricao": "É um drama romântico baseado no livro de Jojo Moyes, focado na transformação da vida de Will Traynor, um homem rico, esportista e ativo que se torna tetraplégico após um acidente. Depressivo e cínico, ele contrata Louisa Clark, uma jovem excêntrica e modesta, como cuidadora, mudando a vida de ambos. ",
    },
    {
      "nome": "O badboy e eu",
      "imagem": "../images/filme2.jpg",
      "descricao": "Um romance adolescente que segue a história de uma jovem que se apaixona por um badboy, enfrentando desafios e descobrindo o poder do amor verdadeiro. É um filme de romance adolescente baseado em uma história de sucesso do Wattpad, focado na dinâmica entre uma dançarina focada e um jogador de futebol americano popular. ",
    },
    {
      "nome": "Wicked",
      "imagem": "../images/filme3.jpg",
      "descricao": "É um renomado musical da Broadway e, mais recentemente, uma superprodução cinematográfica dividida em duas partes, que funciona como um prelúdio e releitura de O Mágico de Oz. A história explora a amizade improvável entre duas bruxas e revela a verdadeira origem da Bruxa Má do Oeste, mudando a perspectiva clássica da história.",
    },
    {
      "nome": "Viva a vida é uma festa",
      "imagem": "../images/filme4.jpg",
      "descricao": "É uma animação da Pixar que retrata a jornada de Miguel, um menino de 12 anos que sonha ser músico, mas sua família proíbe música. No Día de Muertos, ele é transportado para a vibrante e colorida Terra dos Mortos, onde busca seu ídolo e descobre segredos familiares sobre amor, memória e ancestralidade. ",
    },
    {
      "nome": "A empregada",
      "imagem": "../images/filme5.jpg",
      "descricao": "É um thriller psicológico de ritmo acelerado que narra a história de Millie, uma ex-presidiária que aceita emprego como empregada doméstica na mansão de Nina e Andrew Winchester, envolvendo-se em segredos obscuros, manipulação e reviravoltas perigosas. ",
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