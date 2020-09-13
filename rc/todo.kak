declare-option str todo_filetype 'todo'
declare-option str todo_dir "~/.todo"
declare-option str todo_mark '✓'

# TODO: add command to open different project
# 
# a project is defined in the todo direactory
# this command opens default project, e.g. default.%opt{todo_filetype}
define-command todo-open-default-project %{
    edit "%opt{todo_dir}/default.%opt{todo_filetype}"
} -docstring "open default todo project"

provide-module kak_todo %§

hook global BufCreate ".*.%opt{todo_filetype}" %{
    map buffer insert <ret> "<a-;>\o- [ ] <esc>"
    map buffer insert > "<a-;>>"
    map buffer insert < "<a-;><"

    declare-user-mode kak-todo
    map buffer kak-todo <ret> %{: toggle-todo<ret>} -docstring "toogle todo"
    map buffer kak-todo D xd -docstring "delete todo"
    map buffer kak-todo a "i<a-;>\o- [ ] <esc>" -docstring "add todo bellow current line"
    map buffer kak-todo A "gei<a-;>\o- [ ] <esc>" -docstring "add todo at the end of buffer"
    map buffer kak-todo b "i<a-;>\O- [ ] <esc>" -docstring "add todo before current line"
    map buffer kak-todo B "gki<a-;>\O- [ ] <esc>" -docstring "add todo at the start of buffer"
    map buffer kak-todo o "i<a-;>\o- [ ] <esc><a-;>>" -docstring "nested todo under todo"

    # write todo file on changing mode
    hook buffer ModeChange ".*:normal" %{
        evaluate-commands w
    }
}

define-command toggle-todo %{
    try %{
        # mark todo as complete
    	execute-keys -draft "ghx_s\[ <ret>;r%opt{todo_mark}"
    } catch %{
        # mark todo as un-complete
        execute-keys -draft "ghf[lr "
    }
} -docstring 'toogle todo as marked and unmarked'

§
