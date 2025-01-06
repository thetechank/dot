# NeoVim VsCode Bindings

 Keys are keys either by VSCode or modified by me in Keyboard Shortcuts

## Editing

| Key           | VSCode Command                          | Source | KeyMac        | KeyWin        |
| --------------| ----------------------------------------|--------|---------------|---------------|
| `<leader>p`   | `Paste last copied from Register-"0p`   |  ank   |               |               |
| `<leader>P`   | `Paste from system clipboard-"+p`       |  ank   |               |               |
| `<leader>D`   | `Delete Everything-gg0vG"_d`            |  ank   |               |               |
| `<leader>d`   | `Delete to clipboard-"+d`               |  ank   |               |               |
| `<leader>c`   | `Change to clipboard-"+c"`              |  ank   |               |               |
| `<leader>nh`  | `Clear search highlights`               |  ank   |               |               |
| `<leader>fmt` | `editor.action.formatDocument`          |  ank   | `Shift-Opt-F` | `Shift-Alt-F` |
| `<leader>fmn` | `editor.action.formatDocument.none`     |  ank   | `Shift-Opt-F` | `Shift-Alt-F` |
| `<leader>fmw` | `editor.action.formatDocument.multiple` |  ank   | `Shift-Opt-W` | `Shift-Alt-W` |

## File Explorer Bindings

| Key          | VSCode Command                                | Source | KeyMac       | KeyWin        |
| ------------ | ----------------------------------------------|--------|--------------|---------------|
| `<leader>ex` | `workbench.action.toggleSidebarVisibility`    |  ank   | `Cmd-B`      | `Ctrl-B`      |
| `<leader>ee` | `workbench.files.action.focusFilesExplorer`   |  ank   | `Cmd-Shift-E`| `Ctrl-Shift-E`|
| `<leader>eo` | `workbench.files.action.focusOpenEditorsView` |  ank   | `Cmd-K E`    | `Ctrl-K E`    |
| `<leader>eq` | `workbench.action.focusActiveEditorGroup`     |  ank   | `Shift-Esc`  | `Shift-Esc`   |

## File Explorer File Manipulation Bindings

| Key | VSCode Command                               | Source | KeyMac       | KeyWin       |
| --- | ---------------------------------------------|--------|--------------|--------------|
| `r` | `renameFile`                                 |  nvim  |              |              |
| `d` | `deleteFile`                                 |  nvim  |              |              |
| `y` | `filesExplorer.copy`                         |  nvim  |              |              |
| `x` | `filesExplorer.cut`                          |  nvim  |              |              |
| `p` | `filesExplorer.paste`                        |  nvim  |              |              |
| `v` | `explorer.openToSide`                        |  nvim  |              |              |
| `a` | `explorer.newFile`                           |  nvim  |              |              |
| `A` | `explorer.newFolder`                         |  nvim  |              |              |
| `R` | `workbench.files.action.refreshFilesExplorer`|  nvim  |              |              |

## Explorer/list Navigation Bindings

| Key             | VSCode Command                  | Source | KeyMac       | KeyWin       |
| --------------- | ------------------------------- |--------|--------------|--------------|
| `j` or `k`      | `list.focusDown/Up`             |  nvim  |              |              |
| `h` or `l`      | `list.collapse/select`          |  nvim  |              |              |
| `Enter`         | `list.select`                   |  nvim  |              |              |
| `gg`            | `list.focusFirst`               |  nvim  |              |              |
| `G`             | `list.focusLast`                |  nvim  |              |              |
| `o`             | `list.toggleExpand`             |  nvim  |              |              |
| `C-u` or `C-d`  | `list.focusPageUp/Down`         |  nvim  |              |              |
| `zo` or `zO`    | `list.expand`                   |  nvim  |              |              |
| `zc`            | `list.collapse`                 |  nvim  |              |              |
| `zC`            | `list.collapseAllToFocus`       |  nvim  |              |              |
| `za` or `zA`    | `list.toggleExpand`             |  nvim  |              |              |
| `zm` or `zM`    | `list.collapseAll`              |  nvim  |              |              |
| `/` or `Escape` | `list.toggleKeyboardNavigation` |  nvim  |              |              |

## Window Management

| Key          | VSCode Command                       | Source | KeyMac              | KeyWin               |
| -------------| -------------------------------------|--------|---------------------|----------------------|
| `<leader>wv` | `workbench.action.splitEditorRight`  |  ank   |                     |                      |
| `Ctrl-W v`   | `workbench.action.splitEditorRight`  |  nvim  |                     |                      |
| `<leader>ws` | `workbench.action.splitEditorDown`   |  ank   |                     |                      |
| `Ctrl-W s`   | `workbench.action.splitEditorDown`   |  nvim  |                     |                      |
| `<leader>wq` | `workbench.action.closeActiveEditor` |  ank   |                     |                      |
| `Ctrl-W q`   | `workbench.action.closeActiveEditor` |  nvim  |                     |                      |
| `Ctrl-W c`   | `workbench.action.closeActiveEditor` |  nvim  |                     |                      |
| ``           | `Close Window`                       | vscode | `Cmd-W`             | `Ctrl-Shift-W`       |
| ``           | `Open/Toggle Terminal`               | vscode | `Ctrl-\``           | `Ctrl-\``            |
| ``           | `Hide Panel`                         | vscode | `Shift-\``          | `Shift-\``           |
| ``           | `Toggle Panel`                       | vscode | `Cmd-J`             | `Ctrl-J`             |
| ``           | `Adjust Current View Size`           | vscode | `Ctrl-Shift-Up/Down`| `Ctrl-Shift-Up/Down` |
| ``           | `Maximized Panel`                    | vscode | `Cmd-K Cmd-U`       | `Ctrl-K Ctrl-U`      |

## LSP Bindings

| Key           | VSCode Command                          | Source | KeyMac          | KeyWin          |
| ------------- | ----------------------------------------|--------|---------------- |-----------------|
| `<leader>gd`  | `editor.action.revealDefinition`        |  ank   | `Ctrl-G D`      | `Ctrl-G D`      |
| `gd`/`C-]`    | `editor.action.revealDefinition`        |  nvim  | `Ctrl-G D`      | `Ctrl-G D`      |
| `gD`          | `editor.action.peekDefinition`          |  nvim  |                 |                 |
| `<leader>gdd` | `editor.action.revealDefinitionAside`   |  ank   | `Ctrl-G Ctrl-D` | `Ctrl-G Ctrl-D` |
| `C-w` `gd`/   | `editor.action.revealDefinitionAside`   |  nvim  | `Ctrl-G Ctrl-D` | `Ctrl-G Ctrl-D` |
| `C-w` `gf`    | `editor.action.revealDefinitionAside`   |  nvim  | `Ctrl-G Ctrl-D` | `Ctrl-G Ctrl-D` |
| `<leader>gr`  | `editor.action.goToReferences`          |  ank   | `Ctrl-G R`      | `Ctrl-G R`      |
| `gR`          | `editor.action.referenceSearch.trigger` |  ank   |                 |                 |
| `gH`          | `editor.action.referenceSearch.trigger` |  nvim  |                 |                 |
| `<leader>gi`  | `editor.action.goToImplementation`      |  ank   | `Ctrl-G I`      | `Ctrl-G I`      |
| `gI`          | `editor.action.peekImplementation`      |  ank   |                 |                 |
| `<leader>gt`  | `editor.action.goToTypeDefinition`      |  ank   | `Ctrl-G T`      | `Ctrl-G T`      |
| `gT`          | `editor.action.peekTypeDefinition`      |  ank   |                 |                 |
| `<leader>gf`  | `editor.action.revealDeclaration`       |  ank   |                 |                 |
| `gf`          | `editor.action.revealDeclaration`       |  nvim  |                 |                 |
| `gF`          | `editor.action.peekDeclaration`         |  nvim  |                 |                 |
| `<leader>gs`  | `workbench.action.gotoSymbol`           |  ank   | `Cmd-Shift-.`   | `Ctrl-Shift-.`  |
| `gO`          | `workbench.action.gotoSymbol`           |  nvim  |                 |                 |
| `<leader>gss` | `editor.action.accessibleViewGoToSymbol`|  ank   | `Cmd-Shift-.`   | `Ctrl-Shift-.`  |
| `<leader>gws` | `workbench.action.showAllSymbols`       |  ank   | `Cmd-T`         | `Ctrl-T`        |
| `<leader>rn`  | `editor.action.rename`                  |  ank   | `F2`            |  `F2`           |
| `<leader>k`   | `editor.action.showHover`               |  ank   | `Cmd-K Cmd-H`   | `Ctrl-K Ctrl-H` |
| `gh`/`K`      | `editor.action.showHover`               |  nvim  | `Cmd-K Cmd-I`   | `Ctrl-K Ctrl-I` |
| `Shift-k`     | `editor.action.showHover`               |  nvim  | `Cmd-K Cmd-I`   | `Ctrl-K Ctrl-I` |
| `<leader>ca`  | `editor.action.quickFix`                |  ank   | `Cmd-.`         | `Ctrl-.`        |
| `<leader>xa`  | `workbench.actions.view.problems`       |  ank   | `Cmd-Shift-M`   | `Ctrl-Shift-M`  |
| `<leader>xp`  | `editor.action.marker.prev`             |  ank   | `Shift-Opt-F8`  | `Shift-Alt-F8`  |
| `<leader>xn`  | `editor.action.marker.next`             |  ank   | `Opt-F8`        | `Alt-F8`        |
| `<leader>dg`  | `workbench.debug.action.toggleRepl`     |  ank   | `Cmd-Shift-Y`   | `Ctrl-Shift-Y`  |
| `<leader>op`  | `workbench.action.output.toggleOutput`  |  ank   | `Cmd-Shift-U`   | `Ctrl-Shift-U`  |

## Find

| Key           | VSCode Command                                 |Source  | KeyMac        | KeyWin         |
| ------------- | -----------------------------------------------|--------|---------------|----------------|
| `<leader>ff`  | `workbench.action.quickOpen`                   |  ank   | `Cmd-P`       | `Ctrl-P`       |
| `<leader>b/`  | `actions.find`                                 |  ank   | `Cmd-F`       | `Ctrl-F`       |
| `<leader>b//` | `editor.action.startFindReplaceAction`         |  ank   | `Cmd-Opt-F`   | `Ctrl-Alt-F`   |
| `<leader>fw`  | `workbench.action.findInFiles` current_word    |  ank   | `Cmd-Shift-F` | `Ctrl-Shift-F` |
| `<leader>fww` | `workbench.action.replaceInFiles` current_word |  ank   | `Cmd-Shift-H` | `Ctrl-Shift-H` |
| `<leader>fg`  | `workbench.action.findInFiles`                 |  ank   | `Cmd-Shift-F` | `Ctrl-Shift-F` |
| `<leader>fgg` | `workbench.action.replaceInFiles`              |  ank   | `Cmd-Shift-H` | `Ctrl-Shift-H` |
| ``            | ``                                             |  ank   | `Shift-Opt-F` | `Shift-Alt-F`  |

## Hover Widget Manipulation Bindings

| Key   | VSCode Command                   | Source | KeyMac       | KeyWin       |
| ----- | -------------------------------- |--------|--------------|--------------|
| `K`   | `editor.action.showHover`        |  nvim  |              |              |
| `h`   | `editor.action.scrollLeftHover`  |  nvim  |              |              |
| `j`   | `editor.action.scrollDownHover`  |  nvim  |              |              |
| `k`   | `editor.action.scrollUpHover`    |  nvim  |              |              |
| `l`   | `editor.action.scrollRightHover` |  nvim  |              |              |
| `gg`  | `editor.action.goToTopHover`     |  nvim  |              |              |
| `G`   | `editor.action.goToBottomHover`  |  nvim  |              |              |
| `C-f` | `editor.action.pageDownHover`    |  nvim  |              |              |
| `C-b` | `editor.action.pageUpHover`      |  nvim  |              |              |

## Folds

| Key          | VSCode Command                    | Source | KeyMac            | KeyWin               |
| ------------ | ----------------------------------|--------|-------------------|----------------------|
| `za`         | `editor.toggleFold`               |  ank   |  `Cmd-K Cmd-L`    | `Ctrl-k Ctrl-l`      |
| `zsa`        | `editor.toggleFoldRecursively`    |  ank   |  `Cmd-K Shift-Cmd`| `Ctrl-k Ctrl-Shift-L`|
| `zc`         | `editor.fold`                     |  ank   |  `Cmd-Opt-[`      | `Ctrl-Shift-[`       |
| `zsc`        | `editor.foldRecursively`          |  ank   |  `Cmd-k Cmd-[`    | `Ctrl-k Ctrl-[`      |
| `zo`         | `editor.unfold`                   |  ank   |  `Cmd-Opt-]`      | `Ctrl-Shift-[`       |
| `zso`        | `editor.unfoldRecursively`        |  ank   |  `Cmd-k Cmd-]`    | `Ctrl-k Ctrl-]`      |
| `z]`         | `editor.foldAll`                  |  ank   |  `Cmd-k Cmd-0`    | `Ctrl-k Ctrl-0`      |
| `z[`         | `editor.unfoldAll`                |  ank   |  `Cmd-k Cmd-J`    | `Ctrl-k Ctrl-J`      |
| `zk`         | `editor.gotoPreviousFold`         |  ank   |                   |                      |
| `zj`         | `editor.gotoNextFold`             |  ank   |                   |                      |
| `zh`         | `editor.gotoParentFold`           |  ank   |                   |                      |

## Other Code Navigation Bindings

| Key         | VSCode Command                          | Source | KeyMac       | KeyWin       |
| ----------- | ----------------------------------------|--------|--------------|--------------|
| `>=`/`==`   | `editor.action.formatSelection`         |  nvim  |              |              |
| `Tab`       | `togglePeekWidgetFocus` *2              |  nvim  |              |              |
| `C-n`/`C-p` | Navigate types *3 below                 |  nvim  |              |              |

>*1 Also works in vim help.
>*2 Switch between peek editor and reference list
>*3 types: lists parameter hints suggestions quick-open cmdline history peek reference list
>💡 To specify the default peek mode modify `editor.peekWidgetDefaultFocus` in your settings.