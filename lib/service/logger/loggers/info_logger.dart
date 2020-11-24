import '../log_bloc.dart';
import '../log_level.dart';
import '../logger_base.dart';

class InfoLogger extends LoggerBase {
  // ExternalLoggingService externalLoggingService;

  InfoLogger(LogBloc logBloc, [LoggerBase nextLogger])
      : super(LogLevel.Info, nextLogger) {
    // externalLoggingService = ExternalLoggingService(logBloc);
  }

  @override
  void log(String message) {
    //externalLoggingService.logMessage(logLevel, message);
  }
}
