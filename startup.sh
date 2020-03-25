#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200317
# @UPDATE: 20200325
npx degit sveltejs/template ${PROJECT}
cd ${PROJECT}
npm install
npm install -D svelte-preprocess
npm install -D sass
npx -p @storybook/cli sb init --type svelte
npm i --save-dev enzyme
cp ../svelte.config.js .