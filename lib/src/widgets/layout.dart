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
            Text(AppInterface.motd),
          ],
        ),
        Material(elevation: 5, child: Text('${AppInterface.currentRoom.title}')),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (AppInterface.currentContext.length == index) return const SizedBox(height: 60);
              return Text(
                AppInterface.currentContext[index].toString(),
                style: TextStyle(
                    fontSize: AppInterface.currentContext[index].fontSize,
                    fontStyle: AppInterface.currentContext[index].italic ? FontStyle.italic : FontStyle.normal,
                    fontWeight: AppInterface.currentContext[index].bold ? FontWeight.bold : FontWeight.normal),
              );

              List<Widget> _ideas = [];
              Sentence.fromString(AppInterface.currentContext[index].value).ideas.forEach((element) {
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
            itemCount: AppInterface.currentContext.length + 1,
          ),
        ),
        Material(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: inputController,
                    decoration: const InputDecoration(hintText: 'Input'),
                    onSubmitted: (value) {
                      inputController.text = '';
                      inputNode.requestFocus();
                      setState(() {
                        AppInterface.submit(TextInteraction(value));
                        scrollController.jumpTo(scrollController.position.maxScrollExtent);
                      });
                    },
                    onChanged: (value) => setState(() {}),
                    focusNode: inputNode,
                    autofocus: true,
                  ),
                  Builder(builder: (context) {
                    try {
                      final List<String> allHints =
                          AppInterface.hints.map((e) => e.map((e) => e.asHint).join(' ')).toList();
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
