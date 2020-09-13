## kak-todo

A minimalistic todo manager for kakoune

### Keys
#### Normal mode
```
<ret>  =  toggle todo state, e.g. mark or unmark
a      =  add new todo bellow current line
A      =  add new todo at the end of file
o      =  create nested todo for current todo
D      =  delete current todo
```

#### Insert mode
```
<ret>  = add new todo bellow current line
>      = indent current todo
<      = outdent current todo
```

### Plugin commands
-  `todo-open-default-project` : opens default.%opt{todo_filetype} in todo_dir
-  `toggle-todo` : toggle current todo state, e.g. mark or unmark


### Options
| option | type | default |
|--------|------|---------|
| todo_filetype | str | todo |
| todo_dir | str | ~/.todo |
| todo_mark | str | '✓' |

