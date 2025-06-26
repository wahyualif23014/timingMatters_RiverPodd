// core/extensions/string_extension.dart
extension StringExtension on String {
  // Validation helpers
  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }
  
  bool get isPhoneNumber {
    return RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(this);
  }
  
  bool get isNumeric {
    return RegExp(r'^-?\d+\.?\d*$').hasMatch(this);
  }
  
  bool get isAlphaNumeric {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }
  
  bool get isUrl {
    return RegExp(r'^https?:\/\/[^\s]+$').hasMatch(this);
  }
  
  bool get isStrongPassword {
    // At least 8 characters, one uppercase, one lowercase, one number, one special char
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(this);
  }
  
  // Text manipulation
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  String get capitalizeWords {
    return split(' ').map((word) => word.capitalize).join(' ');
  }
  
  String get camelCase {
    List<String> words = split(' ');
    if (words.isEmpty) return this;
    
    String result = words[0].toLowerCase();
    for (int i = 1; i < words.length; i++) {
      result += words[i].capitalize;
    }
    return result;
  }
  
  String get snakeCase {
    return replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}')
        .replaceAll(' ', '_')
        .toLowerCase();
  }
  
  String get kebabCase {
    return replaceAllMapped(RegExp(r'[A-Z]'), (match) => '-${match.group(0)!.toLowerCase()}')
        .replaceAll(' ', '-')
        .toLowerCase();
  }
  
  // Truncation
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }
  
  String truncateWords(int maxWords, {String suffix = '...'}) {
    List<String> words = split(' ');
    if (words.length <= maxWords) return this;
    return '${words.take(maxWords).join(' ')}$suffix';
  }
  
  // Clean up
  String get removeExtraSpaces {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }
  
  String get removeSpecialCharacters {
    return replaceAll(RegExp(r'[^\w\s]'), '');
  }
  
  String get numbersOnly {
    return replaceAll(RegExp(r'[^\d]'), '');
  }
  
  String get lettersOnly {
    return replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }
  
  // Formatting
  String formatAsCurrency({String symbol = 'Rp', String locale = 'id_ID'}) {
    if (!isNumeric) return this;
    
    double value = double.parse(this);
    String formatted = value.toStringAsFixed(0);
    
    // Add thousands separator
    String result = '';
    int count = 0;
    for (int i = formatted.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        result = '.${result}';
      }
      result = '${formatted[i]}${result}';
      count++;
    }
    
    return '$symbol $result';
  }
  
  String formatAsPercentage({int decimals = 1}) {
    if (!isNumeric) return this;
    double value = double.parse(this);
    return '${(value * 100).toStringAsFixed(decimals)}%';
  }
  
  String formatPhoneNumber() {
    String cleaned = numbersOnly;
    if (cleaned.length >= 10) {
      if (cleaned.startsWith('0')) {
        cleaned = '+62${cleaned.substring(1)}';
      } else if (!cleaned.startsWith('+62')) {
        cleaned = '+62$cleaned';
      }
      
      // Format as +62 XXX XXXX XXXX
      if (cleaned.length >= 13) {
        return '${cleaned.substring(0, 3)} ${cleaned.substring(3, 6)} ${cleaned.substring(6, 10)} ${cleaned.substring(10)}';
      }
    }
    return this;
  }
  
  // Parsing
  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }
  
  int? toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }
  
  double? toDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      return null;
    }
  }
  
  bool? toBool() {
    String lower = toLowerCase();
    if (lower == 'true' || lower == '1' || lower == 'yes') return true;
    if (lower == 'false' || lower == '0' || lower == 'no') return false;
    return null;
  }
  
  // Search and matching
  bool containsIgnoreCase(String other) {
    return toLowerCase().contains(other.toLowerCase());
  }
  
  bool startsWithIgnoreCase(String other) {
    return toLowerCase().startsWith(other.toLowerCase());
  }
  
  bool endsWithIgnoreCase(String other) {
    return toLowerCase().endsWith(other.toLowerCase());
  }
  
  double similarityTo(String other) {
    if (this == other) return 1.0;
    if (isEmpty || other.isEmpty) return 0.0;
    
    int maxLength = [length, other.length].reduce((a, b) => a > b ? a : b);
    int distance = levenshteinDistance(other);
    
    return (maxLength - distance) / maxLength;
  }
  
  int levenshteinDistance(String other) {
    if (isEmpty) return other.length;
    if (other.isEmpty) return length;
    
    List<List<int>> matrix = List.generate(
      length + 1,
      (i) => List.generate(other.length + 1, (j) => 0),
    );
    
    for (int i = 0; i <= length; i++) {
      matrix[i][0] = i;
    }
    
    for (int j = 0; j <= other.length; j++) {
      matrix[0][j] = j;
    }
    
    for (int i = 1; i <= length; i++) {
      for (int j = 1; j <= other.length; j++) {
        int cost = (this[i - 1] == other[j - 1]) ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,        // deletion
          matrix[i][j - 1] + 1,        // insertion
          matrix[i - 1][j - 1] + cost, // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }
    
    return matrix[length][other.length];
  }
  
  // Encryption/Hashing (simple)
  String get md5Hash {
    // Note: You would need to import crypto package for real MD5
    // This is a placeholder implementation
    return hashCode.toString();
  }
  
  // Time parsing
  Duration? toDuration() {
    try {
      List<String> parts = split(':');
      if (parts.length == 2) {
        int hours = int.parse(parts[0]);
        int minutes = int.parse(parts[1]);
        return Duration(hours: hours, minutes: minutes);
      } else if (parts.length == 3) {
        int hours = int.parse(parts[0]);
        int minutes = int.parse(parts[1]);
        int seconds = int.parse(parts[2]);
        return Duration(hours: hours, minutes: minutes, seconds: seconds);
      }
    } catch (e) {
      // Try parsing as minutes only
      int? minutes = toInt();
      if (minutes != null) {
        return Duration(minutes: minutes);
      }
    }
    return null;
  }
  
  // Indonesian specific helpers
  String toIndonesianNumber() {
    return replaceAll('.', ',');
  }
  
  String fromIndonesianNumber() {
    return replaceAll(',', '.');
  }
  
  // Productivity helpers
  bool get isTaskComplete {
    String lower = toLowerCase().trim();
    return lower == 'done' || lower == 'completed' || lower == 'finished' || 
           lower == 'selesai' || lower == 'complete';
  }
  
  String get extractHashtags {
    RegExp hashtagRegex = RegExp(r'#\w+');
    Iterable<RegExpMatch> matches = hashtagRegex.allMatches(this);
    return matches.map((match) => match.group(0)).join(' ');
  }
  
  List<String> get hashtags {
    RegExp hashtagRegex = RegExp(r'#\w+');
    Iterable<RegExpMatch> matches = hashtagRegex.allMatches(this);
    return matches.map((match) => match.group(0)!.substring(1)).toList();
  }
  
  // File helpers
  String get fileExtension {
    int lastDot = lastIndexOf('.');
    if (lastDot == -1) return '';
    return substring(lastDot + 1).toLowerCase();
  }
  
  String get fileName {
    int lastSlash = lastIndexOf('/');
    if (lastSlash == -1) return this;
    return substring(lastSlash + 1);
  }
  
  String get fileNameWithoutExtension {
    String name = fileName;
    int lastDot = name.lastIndexOf('.');
    if (lastDot == -1) return name;
    return name.substring(0, lastDot);
  }
  
  // Color helpers
  bool get isHexColor {
    return RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(this);
  }
  
  // Emoji helpers
  bool get containsEmoji {
    return RegExp(r'[\u{1f300}-\u{1f5ff}\u{1f900}-\u{1f9ff}\u{1f600}-\u{1f64f}\u{1f680}-\u{1f6ff}\u{2600}-\u{26ff}\u{2700}-\u{27bf}\u{1f1e6}-\u{1f1ff}\u{1f191}-\u{1f251}\u{1f004}\u{1f0cf}\u{1f170}-\u{1f171}\u{1f17e}-\u{1f17f}\u{1f18e}\u{3030}\u{2b50}\u{2b55}\u{2934}-\u{2935}\u{2b05}-\u{2b07}\u{2b1b}-\u{2b1c}\u{3297}\u{3299}\u{303d}\u{00a9}\u{00ae}\u{2122}\u{23f3}\u{24c2}\u{23e9}-\u{23ef}\u{25b6}\u{23f8}-\u{23fa}]', unicode: true).hasMatch(this);
  }
}