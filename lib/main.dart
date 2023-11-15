import 'package:flutter/material.dart';
import 'package:namer_app/models/llista_articles.dart';
import 'package:namer_app/ui_widgets/comptador_enter.dart';
import 'package:provider/provider.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              if (value != 'obret') {
                return 'Nom incorrecte';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondRoute()),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LlistaArticles(),
      child: const MyApp(),
    ),
  );
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('First Route'),
        ),
        body: const MyCustomForm());
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: const MyHomePage(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Llista de la compra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstRoute(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Llista compra'),
      ),
      body: const ElMeuBody(),
    );
  }
}

class ElMeuBody extends StatelessWidget {
  const ElMeuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LlistaArticles>(builder: (context, model, _) {
            return TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
                labelText: 'Ingresi un article',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  model.afegeix(Article(id: null, nom: text, quantity: 1));
                }
              },
            );
          }),
        ),
        Expanded(child: Consumer<LlistaArticles>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.count(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value.itemAt(index).nom),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(0.0),
                              child: ComptadorEnter(key: key, index: index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                value.treu(value.itemAt(index));
                              },
                            ),
                          ],
                        )
                      ]),
                );
              },
            );
          },
        )),
      ],
    );
  }
}
