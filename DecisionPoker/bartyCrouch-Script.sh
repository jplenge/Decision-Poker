#!/bin/sh

#  bartyCrouch-Script.sh
#  DecisionPoker
#
#  Created by Jürgen Plenge on 25.07.19.
#  Copyright © 2019 Jodi Szarko. All rights reserved.

if which bartycrouch > /dev/null; then
bartycrouch update -x
else
echo "warning: BartyCrouch not installed, download it from https://github.com/Flinesoft/BartyCrouch"
fi
