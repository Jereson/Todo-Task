import 'package:intl/intl.dart';

extension StringExtension on String {
  String get toDate {
    DateTime date = DateTime.parse(this);
    var newFormat = DateFormat("yMMMd");
    String updatedDt = newFormat.format(date);
    return updatedDt;
  }

  String get toTime {
    DateTime date = DateTime.parse(this);
    var newFormat = DateFormat("jm");
    String updatedDt = newFormat.format(date);
    return updatedDt;
  }

  String get toDateTime {
    DateTime date = DateTime.parse(this);
    var newFormat = DateFormat("yMMMd jm");
    String updatedDt = newFormat.format(date);
    return updatedDt;
  }

  String get toTimeAgo {
    DateTime date = DateTime.parse(this);
    var now = DateTime.now();
    var difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  String get toDateTimeAgo {
    DateTime date = DateTime.parse(this);
    var now = DateTime.now();
    var difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  String get toPng {
    return 'assets/images/$this.png';
  }

  String get replaceSpace {
    return replaceAll(' ', '=');
  }

  String get capitalize {
    if (length == 0) return "";
    if (length == 1) return toUpperCase();
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String titleCase() {
    if (length == 0) return "";
    if (length == 1) return capitalize;
    return split(' ')
        .map((word) {
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  String get fixToJson {
    String input = this;
    // // Step 1: Quote keys (do not touch values yet)
    // input = input.replaceAllMapped(RegExp(r'(\s*)([^\s"\{\}\[\]:]+)\s*:\s*'), (
    //   match,
    // ) {
    //   final key = match[2]!;
    //   return '${match[1]}"$key": ';
    // });

    // // Step 2: Quote only string values without quotes (skip [ or { or numbers or booleans/null)
    // input = input.replaceAllMapped(RegExp(r':\s*([^,"\{\}\[\]\s][^,\}\]]*)'), (
    //   match,
    // ) {
    //   final val = match[1]!.trim();
    //   if (val.isEmpty ||
    //       val == 'true' ||
    //       val == 'false' ||
    //       val == 'null' ||
    //       num.tryParse(val) != null) {
    //     return ': $val';
    //   }
    //   return ': "$val"';
    // });

    // // Step 3: Remove trailing commas
    // input = input.replaceAll(RegExp(r',(\s*[}\]])'), r'\1');

    // return input;

    input = input.replaceAllMapped(
      RegExp(r'(\d{4}-\d{2}-\d{2} \d{2}:\d{2})'),
      (m) => '"${m[1]}"',
    );

    // Step 1: Quote keys
    input = input.replaceAllMapped(RegExp(r'(\s*)([^\s"\{\}\[\]:]+)\s*:\s*'), (
      match,
    ) {
      final key = match[2]!;
      return '${match[1]}"$key": ';
    });

    // Step 2: Quote unquoted string values
    input = input.replaceAllMapped(RegExp(r':\s*([^,"\{\}\[\]\s][^,\}\]]*)'), (
      match,
    ) {
      final val = match[1]!.trim();
      if (val == 'true' ||
          val == 'false' ||
          val == 'null' ||
          num.tryParse(val) != null) {
        return ': $val';
      }
      return ': "$val"';
    });

    // Step 3: Remove trailing commas
    input = input.replaceAll(RegExp(r',(\s*[}\]])'), r'\1');

    return input;
  }
}
