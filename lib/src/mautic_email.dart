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
  ) {
    // E-mails Read Rate
    try {
      if (readCount > 0) {
        var _calc = double.parse(
          (100 * (readCount / sentCount)).toStringAsFixed(2),
        );
        // Mautic sometimes register more opens than emails sent
        readRate = (_calc > 100.00) ? 100.00 : _calc;
      } else {
        readRate = 0.0;
      }
    } catch (e) {
      readRate = 0.0;
    }

    // E-mails Plain Text
    try {
      hasTextPlain = plainText.isNotEmpty;
    } catch (e) {
      hasTextPlain = false;
    }

    if (isPublished) {
      if (publishUp == null) {
        publishedStatus = 'published';
      } else {
        if (publishUp.isAfter(DateTime.now())) {
          publishedStatus = 'scheduled';
        } else {
          if (publishDown == null) {
            publishedStatus = 'sending';
          } else {
            if (publishDown.isBefore(DateTime.now())) {
              publishedStatus = 'expired';
            } else {
              publishedStatus = 'sending';
            }
          }
        }
      }
    } else {
      publishedStatus = 'unpublished';
    }
  }

  /// Mautic Email ID
  final int id;

  /// Mautic Emails isPublished?
  final bool isPublished;

  /// Mautic Email Name
  final String name;

  /// Mautic Email Subject
  final String subject;

  /// Mautic Email From Address
  final String fromAddress;

  /// Mautic Email From Name
  final String fromName;

  /// Mautic Email Reply Address
  final String replyToAddress;

  /// Mautic Email HTML
  final String customHtml;

  /// Mautic Email Plain Text
  final String plainText;

  /// Mautic Email Template Name
  final String template;

  /// Mautic Email Type
  final String emailType;

  /// Mautic Email Language
  final String language;

  /// Mautic Email Start Up
  final DateTime publishUp;

  /// Mautic Email End
  final DateTime publishDown;

  /// Mautic Email Read Count
  final int readCount;

  /// Mautic Email Sent Count
  final int sentCount;

  /// Mautic Email Read Rate
  double readRate;

  /// Mautic Email has Text Plain
  bool hasTextPlain;

  /// Mautic Email Published Status
  String publishedStatus;

  ///
}
