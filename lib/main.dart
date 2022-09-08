import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(const MyWidget());
  await Firebase.initializeApp();
  var armazenamento = FirebaseFirestore.instance.collection('armazem');
  
  armazenamento.doc('1').set({
    'nome': suggestions[0].asPascalCase
  });
  armazenamento.doc('2').set({
    'nome': suggestions[1].asPascalCase
  }); 
  armazenamento.doc('3').set({
    'nome': suggestions[2].asPascalCase
  });
  armazenamento.doc('4').set({
    'nome': suggestions[3].asPascalCase
  }); 
  armazenamento.doc('5').set({
    'nome': suggestions[4].asPascalCase
  });
  armazenamento.doc('6').set({
    'nome': suggestions[5].asPascalCase
  }); 
  armazenamento.doc('7').set({
    'nome': suggestions[6].asPascalCase
  });
  armazenamento.doc('8').set({
    'nome': suggestions[7].asPascalCase
  }); 
  armazenamento.doc('9').set({
    'nome': suggestions[8].asPascalCase
  });
  armazenamento.doc('10').set({
    'nome': suggestions[9].asPascalCase
  }); 
  armazenamento.doc('11').set({
    'nome': suggestions[10].asPascalCase
  });
  armazenamento.doc('12').set({
    'nome': suggestions[11].asPascalCase
  }); 
  armazenamento.doc('13').set({
    'nome': suggestions[12].asPascalCase
  });
  armazenamento.doc('14').set({
    'nome': suggestions[13].asPascalCase
  }); 
  armazenamento.doc('15').set({
    'nome': suggestions[14].asPascalCase
  });
  armazenamento.doc('16').set({
    'nome': suggestions[15].asPascalCase
  }); 
  armazenamento.doc('17').set({
    'nome': suggestions[16].asPascalCase
  });
  armazenamento.doc('18').set({
    'nome': suggestions[17].asPascalCase
  }); 
  armazenamento.doc('19').set({
    'nome': suggestions[18].asPascalCase
  });
  armazenamento.doc('20').set({
    'nome': suggestions[19].asPascalCase
  }); 
  // armazenamento.set({
  //                 'nome1': suggestions[0].asPascalCase,
  //                 'nome2': suggestions[1].asPascalCase,
  //                 'nome3': suggestions[2].asPascalCase,
  //                 'nome4': suggestions[3].asPascalCase,
  //                 'nome5': suggestions[4].asPascalCase,
  //                 'nome6': suggestions[5].asPascalCase,
  //                 'nome7': suggestions[6].asPascalCase,
  //                 'nome8': suggestions[7].asPascalCase,
  //                 'nome9': suggestions[8].asPascalCase,
  //                 'nome10': suggestions[9].asPascalCase,
  //                 'nome11': suggestions[10].asPascalCase,
  //                 'nome12': suggestions[11].asPascalCase,
  //                 'nome13': suggestions[12].asPascalCase,
  //                 'nome14': suggestions[13].asPascalCase,
  //                 'nome15': suggestions[14].asPascalCase,
  //                 'nome16': suggestions[15].asPascalCase,
  //                 'nome17': suggestions[16].asPascalCase,
  //                 'nome18': suggestions[17].asPascalCase,
  //                 'nome19': suggestions[18].asPascalCase,
  //                 'nome20': suggestions[19].asPascalCase
  //             });
} 

final teste = <WordPair>[];

final saved = <WordPair>[];
final listaNome = <WordPair>[];
final suggestions = <WordPair>[];
var palavraVez = "";
int qtdPalavras = 40;

class Argumentos {
  final WordPair nome;
  Argumentos(this.nome);
}
class Repositorio {
  WordPair nomePalavra;
  Repositorio(this.nomePalavra);
}



class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MyApp(),
        TelaEditar.routeName: (context) => const TelaEditar(),
      },
    );
  }
}

class Favoritos extends StatelessWidget {
  const Favoritos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: Text('Voltar'))
        ],
      ),
      body: ListView.builder(
          itemCount: saved.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(saved[index].asPascalCase),
            );
          }),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  palavra() async{
    await Firebase.initializeApp();
    FirebaseFirestore db =  FirebaseFirestore.instance;

    db.collection('armazem').snapshots().listen((event) {
      
    for (var element in event.docs) { 
      setState(() {
        teste.add(WordPair(element.get('nome'), ' '));

      });
    }
    });
    // var testando = FirebaseFirestore.instance.collection('armazem').doc('palavras');
    
  }
  final biggerFont = const TextStyle(fontSize: 18);

  String viewType = 'list';

  lista_card() {
    if (viewType == 'list') {
      palavra();
      return const Text('Cards');
    } else {
      palavra();
      return const Text('Lista');
    }
  }

  botao() {
    if (viewType == 'list') {
      viewType = 'grid';
    } else {
      viewType = 'list';
    }
    setState(() {});
  }

  body(){
    if (viewType == 'list') {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: qtdPalavras,
        itemBuilder: /*1*/ (conext, i) {
          final index = i ~/ 2; /*3*/
          // if(suggestions.length <= 20) {
            if (i.isOdd) return const Divider(); /*2*/

            if (index <= suggestions.length) {
                suggestions.addAll(generateWordPairs().take(20));
          }
          // }
          
          final alreadySaved = saved.contains(suggestions[index]);
          return ListTile(
              title: Dismissible(
                key: ObjectKey(suggestions[index].asPascalCase),
                child: 
                    Text( 
                      suggestions[index].asPascalCase,
                      style: biggerFont,
                    ),
                onDismissed: (direction) {
                  setState(() {
                    suggestions.removeAt(index);
                    // saved.removeAt(index);
                  });
                },
              ),
              trailing: IconButton(
                  icon: alreadySaved
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      palavra();
                      if (alreadySaved) {
                        saved.remove(suggestions[index]);
                      } else {
                        saved.add(suggestions[index]);
                      }
                    });
                  }),
              onTap: () {
                Navigator.pushNamed(context, '/editar',
                    arguments: Argumentos(
                      suggestions[index],
                    ));
              }
              );
              
        },
      );
    } else {
      return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i >= suggestions.length) {
            suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return Card(
            child: Center(
                child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/editar',
                    arguments: Argumentos(
                      suggestions[i],
                    ));
              },
              child: Text(
                suggestions[i].asPascalCase,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            )),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Startup Name Generator', style: TextStyle(fontSize:16),), actions: [
        ElevatedButton(
          onPressed: botao,
          child: lista_card(),
        ),
        IconButton(
          icon: const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Favoritos())),
        ),
        ElevatedButton(onPressed: () =>
          Navigator.pushNamed(context, '/editar', arguments: Argumentos(WordPair(' ',' '))),
        child: const Icon(Icons.add),)
      ]),
      body: body(),
    );
  }
}

class TelaEditar extends StatefulWidget {
  static const routeName = '/editar';

  const TelaEditar({Key? key}) : super(key: key);

  @override
  State<TelaEditar> createState() => _TelaEditarState();
}

class _TelaEditarState extends State<TelaEditar> {
  var count = 21;

  adicionarItem() async{
    await Firebase.initializeApp();
    var armazenamento = FirebaseFirestore.instance.collection('armazem');
    qtdPalavras = qtdPalavras - 2;
    int proxIndex = (qtdPalavras/2).toInt();
    suggestions[proxIndex] = WordPair(palavraVez, ' ');

    armazenamento.doc('$count').set({
      'nome': WordPair(palavraVez, ' ').asPascalCase
    });
    count = count + 1;
    print(teste);
    }

  @override
  Widget build(BuildContext context) {
    final argumentos = ModalRoute.of(context)!.settings.arguments as Argumentos;

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Palavra "),
      ),
      body: Column(
        children: [
          const Center(
              child: Text(
            "Palavra que será editada ou inlcuida: ",
            style: TextStyle(fontSize: 20),
          )),
          Center(
              child: Text(argumentos.nome.asPascalCase,
                  style: const TextStyle(fontSize: 32, color: Colors.red))),
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
                    onChanged: (text) => palavraVez = text,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration( 
                      labelText: "Digite uma plavra para ser adicionada",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      )
              ), 
              )
              ),
              Center(child: ElevatedButton(
                child: Text('Adicionar'),
                onPressed: () => adicionarItem(),
              ),)
        ],
      ),
        ],
      ),
    );
  }
}
