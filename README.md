<p align="center">
    :construction: Work in Progress! :construction:
</p>

<div align="center">
<img alt="Prettier"
  src="https://raw.githubusercontent.com/prettier/prettier-logo/master/images/prettier-icon-light.png">
<img alt="QML" height="180" hspace="25" vspace="15"
  src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Qt_logo_2016.svg/langfr-330px-Qt_logo_2016.svg.png">
</div>

<h2 align="center">Prettier QML Plugin</h2>

<p align="center">
  <a href="https://travis-ci.org/oltodo/prettier-plugin-qml/">
    <img alt="Travis" src="https://img.shields.io/travis/oltodo/prettier-plugin-qml/master.svg?style=flat-square&label=Travis+CI">
  </a>
  <a href="https://ci.appveyor.com/project/oltodo/prettier-plugin-qml">
    <img alt="AppVeyor Build Status" src="https://img.shields.io/appveyor/ci/oltodo/prettier-plugin-qml.svg?style=flat-square&label=AppVeyor">
  </a>
  <a href="https://www.npmjs.com/package/@oltodprettie-plugin-qml
    <img alt="npm version" src="https://img.shields.io/npm/v/plugin-prettier-qml.svg?stylprettie-plugin-qml
  </a>
  <a href="https://codecov.io/gh/oltodo/prettier-plugin-qml">
    <img alt="Codecov Coverage Status" src="https://img.shields.io/codecov/c/github/oltodo/prettier-plugin-qml.svg?style=flat-square">
  </a>
  <!-- <a href="https://www.npmjs.com/package/@oltodprettie-plugin-qml
    <img alt="monthly downloads" src="https://img.shields.io/npm/dm/plugin-prettier-qml.svg?stylprettie-plugin-qml
  </a> -->
  <a href="#badge">
    <img alt="code style: prettier" src="https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square">
  </a>
  <a href="https://gitter.im/jlongster/prettier">
    <img alt="Gitter" src="https://img.shields.io/gitter/room/jlongster/prettier.svg?style=flat-square">
  </a>
  <a href="https://twitter.com/PrettierCode">
    <img alt="Follow+Prettier+on+Twitter" src="https://img.shields.io/twitter/follow/prettiercode.svg?label=follow+prettier&style=flat-square">
  </a>
</p>

## WORK IN PROGRESS

Please note that this plugin is currently in alpha stage and still under active development. We encourage everyone to try it and give feedback, but we don't recommend it for production use yet.

## Intro

Prettier is an opinionated code formatter. It enforces a consistent style by parsing your code and re-printing it with its own rules that take the maximum line length into account, wrapping code when necessary.

This plugin adds support for the QML language to Prettier.

## Install

yarn:

```bash
yarn add --dev prettier prettie-plugin-qml
# or globally
yarn global add prettier prettie-plugin-qml
```

npm:

```bash
npm install --save-dev prettier prettie-plugin-qml
# or globally
npm install --global prettier prettie-plugin-qml
```

## Use

If you installed prettier as a local dependency, you can add prettier as a script in your `package.json`,

```json
"scripts": {
  "prettier": "prettier"
}
```

and then run it via

```bash
yarn run prettier path/to/file.qml --write
# or
npm run prettier -- path/to/file.qml --write
```

If you installed globally, run

```bash
prettier path/to/file.qml --write
```

## Editor integration

### Atom

The official [prettier plugin for atom](https://github.com/prettier/prettier-atom) supports plugins.

### VScode

Regarding plugin support in the official plugin prettier-vscode see [this issue](https://github.com/prettier/prettier-vscode/issues/395).

Alternatively, install [Run on Save](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave) and add the following section to your settings:

```json
"emeraldwalk.runonsave": {
  "commands": [
    {
      "match": "\\.qml$",
        "cmd": "prettier ${file} --write"
    }
  ]
}
```

### Vim

Regarding plugin support in the official plugin vim-prettier see [this issue](https://github.com/prettier/vim-prettier/issues/119).

#### ALE

The linting plugin ALE has built-in support for prettier and its plugins. Just add prettier to your [list of fixers](https://github.com/w0rp/ale#2ii-fixing). For example:

```vim
let g:ale_fixers={
  \'javascript': ['prettier'],
  \'json': ['prettier'],
  \'qml': ['prettier'],
\}
```

#### Custom

Alternatively, adding the following to `.vimrc` will define a custom command `:PrettierQml` that runs the plugin while preserving the cursor position and run it on save.

```vim
" Prettier for QML
function PrettierQmlCursor()
  let save_pos = getpos(".")
  %! prettier --stdin --parser=qml
  call setpos('.', save_pos)
endfunction
" define custom command
command PrettierQml call PrettierQmlCursor()
" format on save
autocmd BufwritePre *.qml PrettierQml
```

## Contributing

If you're interested in contributing to the development of Prettier for QML, you can follow the [CONTRIBUTING guide from Prettier](https://github.com/prettier/prettier/blob/master/CONTRIBUTING.md), as it all applies to this repository too.

To test it out on a QML file:

- Clone this repository.
- Run `yarn`.
- Create a file called `test.qml`.
- Run `yarn prettier test.qml` to check the output.

## Maintainers

<table>
  <tbody>
    <tr>
      <td align="center">
        <a href="https://github.com/czosel">
          <img width="150" height="150" src="https://github.com/czosel.png?v=3&s=150">
          </br>
          Christian Zosel
        </a>
      </td>
      <td align="center">
        <a href="https://github.com/evilebottnawi">
          <img width="150" height="150" src="https://github.com/evilebottnawi.png?v=3&s=150">
          </br>
          Evilebot Tnawi
        </a>
      </td>
    </tr>
  <tbody>
</table>
