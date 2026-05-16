class ExternalLink {
  const ExternalLink({
    required this.label,
    required this.url,
  });

  final String label;
  final String url;

  factory ExternalLink.fromMap(Map<String, dynamic> map) {
    return ExternalLink(
      label: map['label'] as String? ?? '',
      url: map['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'url': url,
    };
  }
}
