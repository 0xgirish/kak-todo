declare-option str todo_filetype 'todo'
declare-option str todo_dir "~/.todo"
declare-option str todo_mark '✓'

declare-option -hidden str _starting_info "Normal mode
<ret>: toggle todo state, e.g. mark or unmark
a: add todo bellow current line
A: add todo at the end of buffer
o: create nested todo under current todo
D: delete current todo

Insert mode
<ret>: create new todo under current one
>: indent current todo
<: outdent current todo
"

# TODO: add command to open different project
# 
# a project is defined in the todo direactory
# this command opens default project, e.g. default.%opt{todo_filetype}
define-command todo-open-default-project %{
    edit "%opt{todo_dir}/default.%opt{todo_filetype}"
    info -title todo %opt{_starting_info}
} -docstring "open default todo project"

hook global BufCreate ".*.%opt{todo_filetype}" %{
    map buffer insert <ret> "<esc>\o- [ ] <esc>i"
    map buffer insert > '<esc>"zZ>"zzi'
    map buffer insert < '<esc>"zZ<"zzi'
    map buffer normal <ret> %{: toggle-todo<ret>} -docstring "toogle todo"
    map buffer normal D xd -docstring "delete todo"
    map buffer normal a "\o- [ ] <esc>i" -docstring "add todo bellow current line"
    map buffer normal A "ge\o- [ ] <esc>i" -docstring "add todo at the end of buffer"
    map buffer normal o "\o- [ ] <esc>>i" -docstring "nested todo under todo"


    # write todo file on changing mode
    hook buffer ModeChange ".*:normal" %{
        evaluate-commands w
        info -title todo "%opt{_starting_info}"
    }
}

define-command toggle-todo %{
    execute-keys '"zZ'
    try %{
        # mark todo as complete 
        execute-keys "ghx_s\[ <ret>s <ret>r%opt{todo_mark};"
    } catch %{
        # mark todo as un-complete
        execute-keys "ghf[lr ;"
    }
    execute-keys '"zz'
} -docstring 'toogle todo as marked and unmarked'
