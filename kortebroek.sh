#!/bin/sh
curl --silent https://www.kanikeenkortebroekaan.nl | grep "body class" | sed 's/<body class="//' | sed 's/">//'