class Message {
  Message(this.value, {this.italic = true, this.owner = '', this.bold = false, this.fontSize});
  String owner;
  String value;
  bool italic;
  bool bold;
  double? fontSize;

  @override
  String toString() {
    // TODO: implement toString
    return '$owner${owner.isEmpty ? '' : ': '}$value';
  }

  static Message newLine() {
    return Message('');
  }
}
