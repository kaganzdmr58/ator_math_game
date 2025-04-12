import 'dart:io';

void main(List<String>? arguments) {
  final args = arguments ?? ['build'];

  if (args.isEmpty) {
    print(
        "Please specify which version to increment: major, minor, patch, or build.");
    exit(1);
  }

  const String pubspecPath = 'pubspec.yaml';
  final File pubspecFile = File(pubspecPath);
  final List<String> lines = pubspecFile.readAsLinesSync();
  String? newVersion;

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('version:')) {
      final parts = lines[i].split(' ');

      final versionNumbers = parts[1].split('+');
      final buildNumber = int.parse(versionNumbers[1]) + 1;

      final versionParts = versionNumbers[0].split('.').map(int.parse).toList();

      switch (args[0].toLowerCase()) {
        case 'major':
          versionParts[0]++;
          versionParts[1] = 0;
          versionParts[2] = 0;
          break;
        case 'minor':
          versionParts[1]++;
          versionParts[2] = 0;
          break;
        case 'patch':
          versionParts[2]++;
          break;
        case 'build':
          lines[i] = 'version: ${versionNumbers[0]}+$buildNumber';
          pubspecFile.writeAsStringSync(lines.join('\n'));
          newVersion = '${versionNumbers[0]}+$buildNumber';
          print('Version updated (Build Only): ${lines[i]}');
          _commitAndPushChanges(newVersion);
          return;
        default:
          print(
              "Invalid parameter! Available commands: major, minor, patch, build.");
          exit(1);
      }

      newVersion =
          '${versionParts[0]}.${versionParts[1]}.${versionParts[2]}+$buildNumber';
      lines[i] = 'version: $newVersion';
      break;
    }
  }

  pubspecFile.writeAsStringSync(lines.join('\n'));
  print(
      'Version updated: ${lines.firstWhere((line) => line.startsWith("version:"))}');

  if (newVersion != null) {
    _commitAndPushChanges(newVersion);
  }
}

void _commitAndPushChanges(String version) {
  try {
    final result =
        Process.runSync('git', ['rev-parse', '--abbrev-ref', 'HEAD']);
    final currentBranch = result.stdout.toString().trim();

    if (currentBranch.isEmpty) {
      print("Failed to detect the current branch!");
      return;
    }

    Process.runSync('git', ['add', 'pubspec.yaml']);
    Process.runSync('git', ['commit', '-m', 'Auto update version to $version']);

    Process.runSync('git', ['tag', version]);

    Process.runSync('git', ['push', 'origin', currentBranch]);
    Process.runSync('git', ['push', 'origin', version]);

    print(
        'Changes committed, tagged ($version), and pushed to branch "$currentBranch".');
  } catch (e) {
    print('Error while pushing changes: $e');
  }
}
