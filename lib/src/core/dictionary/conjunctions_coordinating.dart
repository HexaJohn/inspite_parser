/// https://gist.github.com/paceaux/f0f62e5a4f1b470d9cd13031607c44e3

const _ = '''
AND
NOR
BUT
OR
YET
SO
''';
// FOR

final Set<String> conjunctions = _.split('\n').toSet();
