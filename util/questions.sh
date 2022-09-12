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
# se -y for passado como parametro, os proximos parametros serão executados
# quando a pergunta for respondida com y|Y
# se -n for passado como parametro, os proximos parametros serão executados
# quando a pergunta for respondida com n|N
# example:
#   confirm_question "String question?" -y command_1 command_2 -n command_3 command_4
confirm_question() {
  # store the value of $1 param
  string_question=$1
  # remove the first parameter from the queue
  shift 1

  # store the rest of the parameters in an array
  separator_y_n_params_=
  for j in $(seq 0 $(expr $# - 1)); do
    # store the value of $1 param
    separator_y_n_params_[$j]=$1
    # remove the first parameter from the queue
    shift 1
  done

  separator_y_n_params

  # create a $field that only receive, one character an answer
  # -N 1 limits the field a one character
  while create_field "$string_question [y/n]" -N 1; do
    lenght_question=$lenght_label_field

    if [[ "$(echo "$field" | tr -d '\n')" =~ ^$ ]]; then
      # if $field is empty then, run up_one_line
      up_one_line

    elif [[ "$field" =~ ^y|Y$ ]]; then
      # if $field is y or Y then, run all stored commands at params_y array
      last_i=$(expr ${#params_y[@]} - 1)
      for i in $(seq 0 $last_i); do
        ${params_y[$i]}
      done
      return

    elif [[ "$field" =~ ^n|N$ ]]; then
      # if $field is n or N then, run all stored commands at params_n array
      last_i=$(expr ${#params_n[@]} - 1)
      for i in $(seq 0 $last_i); do
        ${params_n[$i]}
      done
      return

    fi
    return_car
  done
}

# printf "\n\033[1A"
