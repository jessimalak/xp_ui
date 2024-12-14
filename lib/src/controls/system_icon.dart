import 'package:flutter/widgets.dart';

class SystemIcon extends StatelessWidget {
  const SystemIcon(
      {super.key, required this.icon, this.height = 40, this.width = 40});
  final XpSystemIcons icon;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) => Image.asset(
        'assets/system_icons/${icon.name}.png',
        package: 'xp_ui',
        height: height,
        width: width,
        fit: BoxFit.contain,
      );
}

enum XpSystemIcons {
  bluetooth,
  camera,
  cmd,
  computer,
  disc,
  discCdR,
  discCdRom,
  discCdRw,
  discDvd,
  discDvdR,
  discDvdRam,
  discDvdRom,
  discDvdRw,
  discMusic,
  discQuestion,
  email,
  error,
  favorite,
  fileDraw,
  fileImage,
  filePaint,
  fileQuestion,
  fileSearch,
  firewall,
  folderChat,
  folderClose,
  folderDisc,
  folderDocument,
  folderFont,
  folderImage,
  folderMusic,
  folderNew,
  folderOpen,
  folderRecovery,
  folderSearch,
  folderShare,
  folderVideo,
  info1,
  info2,
  joystick,
  keyboard,
  localNetwork,
  mouse,
  mute,
  network,
  notepad,
  presentation,
  printer,
  program,
  question,
  readerDisc,
  readerDiskette,
  recyclerBinEmpty,
  recyclerBinFull,
  run,
  scanner,
  sdCard,
  search,
  shield,
  shieldError,
  shieldQuestion,
  shieldSuccess,
  shieldWarning,
  sound,
  systemLock,
  systemPower,
  taskManager,
  userAccount,
  videoCamera,
  volume,
  warning,
}