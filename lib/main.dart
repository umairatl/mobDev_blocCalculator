import 'package:bloc_example/calcpage.dart';
import 'package:bloc_example/counter%20_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => CounterCubit(),
          child: const MyHomePage(
            //myhomepage is the charge of the bloc
            title: 'bloc',
          )),
      routes: {
        '/calcPage': (context) => calcPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;

  late CounterCubit cubit;

  @override
  void didChangeDependencies() {
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }

  void multiplication(stateVal, inputVal) {
    Navigator.pushNamed(
      context,
      '/calcPage',
      arguments: {'stateVal': stateVal, 'inputVal': inputVal},
    );
  }

  @override
  Widget build(BuildContext context) {
    final _textNumberController = TextEditingController();

    return Scaffold(
        appBar: AppBar(title: Text('Bloc')),
        body: BlocConsumer<CounterCubit, int>(
            listener: (context, state) {
              const snackbar = SnackBar(
                content: Text('State is reached'),
              );

              if (state == 5) {
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            },
            bloc: cubit,
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _textNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Input The Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Text(
                      '$state',
                      style: TextStyle(fontSize: 30),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.increment();
                      },
                      child: const Text(
                        "Increment",
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          cubit.decrement();
                        },
                        child: const Text('Decrement')),
                    ElevatedButton(
                        onPressed: () {
                          cubit.reset();
                        },
                        child: const Text('Reset')),
                    ElevatedButton(
                        onPressed: () {
                          multiplication(state, _textNumberController.text);
                          // cubit.multiplication();
                        },
                        child: Text('Multiply')),
                    ElevatedButton(
                        onPressed: () {
                          cubit.division();
                        },
                        child: Text('Divide'))
                  ],
                ),
              );
            }));
  }
}
