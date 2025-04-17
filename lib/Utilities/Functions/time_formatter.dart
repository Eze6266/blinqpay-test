import 'package:intl/intl.dart';

String timeAgo(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final diff = DateTime.now().difference(date);
  if (diff.inMinutes < 1) return "Just now";
  if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
  if (diff.inHours < 24) return "${diff.inHours} hr ago";
  return DateFormat('MMM dd, yyyy').format(date);
}
