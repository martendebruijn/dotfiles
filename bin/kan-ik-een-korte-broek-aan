#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Kan ik een korte broek aan?
# @raycast.mode fullOutput
# @raycast.packageName Raycast Scripts by Marten
# @raycast.icon 🤖
# @raycast.description Kan ik een korte broek aan?
# @raycast.author Marten de Bruijn
# @raycast.authorURL https://www.github.com/martendebruijn

curl --silent https://www.kanikeenkortebroekaan.nl | grep "body class" | sed 's/<body class="//' | sed 's/">//'