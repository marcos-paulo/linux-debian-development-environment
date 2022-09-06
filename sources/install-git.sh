sudo apt install git -y
echo status install git $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

# $1 texto que deve ser impresso como erro
print_error() {
  printf "$1"
}

# $1 string que vai ser testada
# $2 padrão que vai testar a string
match_regex() {
  match=$(echo "$1" | grep -P "$2")
  [[ -n $match ]] && return 1 || return 0
}

question_name() {
  while create_field "Informe o seu nome"; do
    match_regex "$field" "^[0-9a-zA-Z\s-_.@]{3,}$"
    [[ $? -eq 1 ]] && { # se verdadeiro atribua $field ao $name
      name=$field
      break
    } # caso contrário imprima o erro
    erro="O Nome deve ter pelo menos 3 caracteres do grupo [ 0-9 a-z A-Z \s - _ . @]."
    print_error "$erro"
    move_cursor_to_first_column "$erro"
    up_one_line # não passou na validação suba uma linha
  done

  confirm_question "O nome \033[34m$name\033[0m está correto?"
  [ $? -eq 0 ] && {
    # Se a resposta foi n|N vai retornar 0 quer dizer que o nome está incorreto
    # logo aqui será implementado o comportamento para repetir a questão.
    clear_line
    up_one_line
    question_name # chama question_name novamente
  }

}

question_name

question_email() {
  while create_field "Informe o seu e-mail"; do
    match_regex "$field" "^[a-z0-9._-]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?$"
    [[ $? -eq 1 ]] && { # se verdadeiro atribua $field ao $email
      email=$field
      break
    } # caso contrário imprima o erro
    erro="O e-mail deve ter pelo menos 5 caracteres do grupo [ 0-9 a-z - _ @ . ], que devem atender ao padrão a@b.c"
    print_error "$erro"
    move_cursor_to_first_column "$erro"
    up_one_line # não passou na validação suba uma linha
  done

  confirm_question "O e-mail \033[34m$email\033[0m está correto?"
  [ $? -eq 0 ] && {
    # zero quer dizer que o email está incorreto logo aqui será implementado o
    # comportamento para repetir a questão
    clear_line
    up_one_line
    question_email # chama question_email novamente
  }
}

question_email

question_email_is_username() {
  # questiona se o email já digitado será o user.name do git hub
  confirm_question "O e-mail \033[34m$email\033[0m é o seu usuario do GitHub?"
  [ $? -eq 1 ] &&
    # 1 = y|Y entao atribue o e-mail ao usuário do GitHub
    user_name=$email ||
    # 0 = n|N quebre alinha para iniciar novo field
    break_line
}

question_email_is_username

question_username() {
  string_question_username="Informe o seu nome de usuário GitHub"
  [ -z $user_name ] && {
    while create_field "$string_question_username"; do
      match_regex "$field" "^[0-9a-z-_@.]{3,}$"
      [[ $? -eq 1 ]] && { # se verdadeiro atribua $field ao $user_name
        user_name=$field
        break
      } # caso contrário imprima o erro
      erro="O nome do usuário deve ter pelo menos 3 caracteres do seguinte grupo [ 0-9 a-z - _ @ . ]"
      print_error "$erro"
      move_cursor_to_first_column "$erro"
      up_one_line # não passou na validação suba uma linha
    done
  } || {
    create_label "$string_question_username" "$user_name"
  }

  confirm_question "O nome de usuário GitHub ${AZUL}${user_name}${NORMAL} está correto?"
  [ $? -eq 0 ] && {
    # zero quer dizer que o usuário está incorreto logo aqui será implementado
    # o comportamento para repetir question_username
    clear_line
    up_one_line

    user_name=        #limpa o conteudo de user_name
    question_username # chama question_username novamente
  }
}

question_username

write_log_git() {
  write_log "[GIT] $1"
}

write_log_git "Configurando Git com os dados informados"
git config --global user.name "$name"
git config --global user.email "$email"
git config --global user.username "$user_name"

write_log_git "Definindo a branch default 'main'"
git config --global init.defaultBranch main

write_log_git "Definindo vscode como editor padrão do git"
git config --global core.editor "code --wait"

write_log_git "Definindo vscode como difftool padrão do git"
git config --global diff.tool "vscode"
git config --global difftool.vscode.cmd "code --wait --diff \$LOCAL \$REMOTE"

show_cursor
