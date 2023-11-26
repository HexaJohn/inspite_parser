import 'package:flutter/material.dart';
import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/grammar/sentence.dart';

class TextScaffold extends StatefulWidget {
  const TextScaffold({super.key});

  @override
  State<TextScaffold> createState() => _TextScaffoldState();
}

class _TextScaffoldState extends State<TextScaffold> {
  final inputController = TextEditingController();
  final inputNode = FocusNode();
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Alpha Build 0'),
            const Spacer(),
            Text(App.motd),
          ],
        ),
        Material(elevation: 5, child: Text('${App.currentRoom.title}')),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (App.currentContext.length == index) return const SizedBox(height: 60);
              return Text(
                App.currentContext[index].toString(),
                style: TextStyle(
                    fontSize: App.currentContext[index].fontSize,
                    fontStyle: App.currentContext[index].italic ? FontStyle.italic : FontStyle.normal,
                    fontWeight: App.currentContext[index].bold ? FontWeight.bold : FontWeight.normal),
              );

              List<Widget> _ideas = [];
              Sentence.fromString(App.currentContext[index].value).ideas.forEach((element) {
                _ideas.add(Container(
                    color: Colors.white10,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(4),
                    child: Text(element.toString(grammar: false))));
              });
              return Row(
                children: _ideas,
              );
            },
            itemCount: App.currentContext.length + 1,
          ),
        ),
        Material(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Builder(builder: (context) {
                        try {
                          return Container(
                            child: AnalysisWidget('Analysis', App.playerInputs.last),
                          );
                        } catch (e) {
                          return Container();
                          // TODO
                        }
                      }),
                      Builder(builder: (context) {
                        try {
                          return Container(
                            child: AnalysisWidget('Analysis Comp.', App.playerInputs[App.playerInputs.length - 2]),
                          );
                        } catch (e) {
                          return Container();
                          // TODO
                        }
                      }),
                    ],
                  ),
                  TextField(
                    controller: inputController,
                    decoration: const InputDecoration(hintText: 'Input'),
                    onSubmitted: (value) {
                      inputController.text = '';
                      inputNode.requestFocus();
                      setState(() {
                        App.submit(TextInteraction(value));
                        scrollController.jumpTo(scrollController.position.maxScrollExtent);
                      });
                    },
                    onChanged: (value) => setState(() {}),
                    focusNode: inputNode,
                    autofocus: true,
                  ),
                  Builder(builder: (context) {
                    try {
                      final List<String> allHints = App.hints.map((e) => e.map((e) => e.asHint).join(' ')).toList();
                      final List<String> filterHints = List.from(allHints);
                      filterHints.retainWhere((element) => element.startsWith('${inputController.text.toUpperCase()}'));
                      final String hints = filterHints.join(' | ');
                      return Row(
                        children: [
                          Text(hints.toLowerCase()),
                        ],
                      );
                    } catch (e) {
                      return Row(
                        children: [],
                      );
                    }
                  })
                ],
              ),
            ))
      ],
    );
  }
}

class AnalysisWidget extends StatelessWidget {
  const AnalysisWidget(
    this.title,
    this.sentence, {
    super.key,
  });

  final Sentence sentence;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Builder(builder: (_) {
          final Idea current = sentence.ideas.first;
          List<Text> children = [
            Text('Direct Object: ${current.directObject}'),
            Text('Indirect Object: ${current.indirectObject}'),
            Text('Predicate: ${current.predicate}'),
            Text('Subject: ${current.subject}'),
            Text('Subject Compliment: ${current.subjectComplement}'),
            // Text('Preposition: ${current.preposition}'),
          ];

          return Column(children: children);
        })
      ],
    );
  }
}
