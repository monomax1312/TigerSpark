import '../../../l10n/generated/app_localizations.dart';

class ErrorMessageMapper {
  ErrorMessageMapper(this._l10n);

  final AppLocalizations _l10n;

  String toUserMessage(Object error, {String? fallbackKey}) {
    final msg = error.toString();
    if (msg.isEmpty) return _l10n.errorUnknown;
    if (msg.contains('FormatException') || msg.contains('json')) return _l10n.errorData;
    if (msg.contains('SocketException') || msg.contains('Connection')) return _l10n.errorNetwork;
    return _l10n.errorUnknown;
  }
}
