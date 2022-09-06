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
import 'package:args/command_runner.dart';
import 'package:flunt_dart/flunt_dart.dart';
import '../logger.dart';

abstract class CommandBase<T> extends Command<T> {
  void validate(Contract contract) async {
    if (contract.invalid) {
      logger.e('Invalid args:');
      contract.notifications.forEach((notification) {
        logger.d('${notification.property} - ${notification.message} ');
      });
      logger.d('\n$usage');
      exit(64);
    }
  }
}
