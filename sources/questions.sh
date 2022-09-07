#!/bin/bash
# TODO refactore optmize function: merge start label and red label functions into one function
start_label() {
  string_label="$1: "                 # label do field
  lenght_label_field=${#string_label} # tamanho do label
  clear_line                          # limpa a linha
  printf "$string_label"              # mostra o label
  printf "$MAGENTA"                   # define uma cor a partir daqui conforme tabela ANSI
  show_cursor                         # mostra o cursor
}

end_label() {
  printf "$NORMAL" # limpa as formatações
  hide_cursor      # oculta o cursor
}

# $1 string do label do field
# $2 e $3 são parametros do field
create_field() {
  start_label "$1"
  read $2 $3 field # define um read para a variavel de nome field
  end_label
}

# TODO refactore optmize function: remove
# $1 string do label do field
# $2 é o valor do campo
create_label() {
  start_label "$1"
  printf "$2"
  end_label
  break_line
}

# $1 - string question
# $2 - function callback if [y|Y]
# $3 - function callback if [n|N]
confirm_question() {
  while create_field "$1 [y/n]" -N 1; do
    lenght_question=$lenght_label_field

    # este bloco representa um if com operadores ternarios
    # && representa o true
    # || representa o else
    [[ "$(echo "$field" | tr -d '\n')" =~ ^$ ]] && up_one_line || {

      [[ "$field" =~ ^y|Y$ ]] && {
        # quebra a linha é padrão para todas as questões pois ao responder y|Y
        # sempre irá saltar para a proxima linha
        break_line
        $2
        return 1
      }

      [[ "$field" =~ ^n|N$ ]] && {
        # Ao responder n|N cada questão poderá implementar o comportamento do
        # cursor de forma diferente baseado no fato de que o cursor vai estar
        # na primeira coluna.
        # Ao responder n|N será chamada a função armazenada no parametro $3 caso
        # exista
        move_cursor_to_first_column "$string_label"
        $3
        return 0
      }

      printf "\n\033[1A"
    }

  done
}
