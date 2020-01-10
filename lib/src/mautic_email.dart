/// Mautic Email
class MauticEmail {
  /// Constructor
  MauticEmail(
    this.id,
    this.isPublished,
    this.name,
    this.subject,
    this.fromAddress,
    this.fromName,
    this.replyToAddress,
    this.customHtml,
    this.plainText,
    this.template,
    this.emailType,
    this.language,
    this.publishUp,
    this.publishDown,
    this.readCount,
    this.sentCount,
  );

  final int id;

  final bool isPublished;

  final String name;

  final String subject;

  final String fromAddress;

  final String fromName;

  final String replyToAddress;

  final String customHtml;

  final String plainText;

  final String template;

  final String emailType;

  final String language;

  final DateTime publishUp;

  final DateTime publishDown;

  final int readCount;

  final int sentCount;

  ///
}
