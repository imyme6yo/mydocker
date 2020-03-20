#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200317
# @UPDATE: 20200319

create-react-app ${PROJECT}
cd ${PROJECT}
npx -p @storybook/cli sb init