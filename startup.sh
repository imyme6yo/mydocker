#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200325
ash
printf '%s\nmyapp\n' "$PROJECT" | npx create-nuxt-app
# npx create-nuxt-app ${PROJECT}
# cd ${PROJECT}

# npx -p @storybook/cli sb init --type vue
# npm i --save-dev enzyme

# ? Project name myapp
# ? Project description My stupendous Nuxt.js project
# ? Author name
# ? Choose programming language TypeScript
# ? Choose the package manager Npm
# ? Choose UI framework Vuetify.js
# ? Choose custom server framework None (Recommended)
# ? Choose the runtime for TypeScript Default
# ? Choose Nuxt.js modules Axios, Progressive Web App (PWA) Support
# ? Choose linting tools ESLint
# ? Choose test framework Jest
# ? Choose rendering mode Universal (SSR)
# ? Choose development tools (Press <space> to select, <a> to toggle all, <i> to invert selection)