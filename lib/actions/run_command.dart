//Copyright 2020 Pedro Bissonho
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.
import 'dart:io';

import 'package:fast/core/fast_process.dart';
import 'package:path/path.dart';
import 'package:fast/core/action.dart';
import 'package:fast/yaml_manager.dart';

import '../logger.dart';

class RunCommandAction implements Action {
  final String yamlCommandPath;
  final Directory workingDirectory;
  final String commandName;

  RunCommandAction(
      this.workingDirectory, this.commandName, this.yamlCommandPath);

  @override
  Future<void> execute() async {
    final yamlCommand = YamlManager.readerYamlCommandsFile(
            normalize('$yamlCommandPath/commands.yaml'))
        .firstWhere((yamlCommand) => yamlCommand.key == commandName);
    //flutter pub add velocity_x && pub add get ** mbc responsive --name services**npm responsive --name services
    //**  flutter pub add velocity_x&&pub add get   mbc responsive --name services npm responsive --name services

    for (var envCmd in yamlCommand.command.trim().split(' ** ')) {
      // env splitter
      final splited = envCmd.split(' ');
      logger.d('yamlCommand:$envCmd');
      final name = splited[0];
      logger.d('name:$name');
      final splited2 =
          envCmd.replaceAll(name, '').trim().split(' && '); // cmd splitter
      //velo: flutter pub add velocity_x && flutter pub add get
      logger.d('splt2:$splited2');
      for (var cmd in splited2) {
        logger.d('cmd:$cmd');
        final cmdList = cmd.split(' ');
        await FastProcessCLI()
            .executeProcess(name, cmdList, workingDirectory.path);
      }
    }
  }

  @override
  String get succesMessage => 'Run command.';
}

// flutter pub add velocity_x && pub add get
