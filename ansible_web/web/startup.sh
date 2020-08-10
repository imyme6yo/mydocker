#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200801
# @UPDATE: 20200803
npx degit sveltejs/template $SERVICE
cd $SERVICE
npm install
npm install --save-dev autoprefixer
npm install --save-dev @fullhuman/postcss-purgecss 
npm install --save-dev postcss postcss-load-config postcss-import postcss-nested
npm install --save-dev svelte-preprocess 
npm install --save-dev tailwindcss
npx tailwind init

cp ../tailwindcss/postcss.config.js ./postcss.config.js
cp ../tailwindcss/Tailwindcss.svelte ./src/Tailwindcss.svelte
cp ../tailwindcss/App.svelte ./src/App.svelte
cp ../tailwindcss/rollup.config.js ./rollup.config.js
cp ../tailwindcss/tailwind.config.js ./tailwind.config.js

npx -p @storybook/cli sb init --type svelte