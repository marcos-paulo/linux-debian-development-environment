#!/bin/bash

# $1 string de onde o cursor tem que ser movido
move_cursor_to_first_column() {
  # pega a quantidade de caracteres de $1
  lenght_line=${#1}
  # a move o cursor n colunas para a esquerda, onde n = $lenght_line
  printf "\033[${lenght_line}D"
}

clear_line() {
  printf "\033[2K" # limpa a linha
}

show_cursor() {
  printf "\033[?25h"
}

hide_cursor() {
  printf "\033[?25l"
}

up_one_line() {
  printf "\033[1A"
}

up_two_line() {
  printf "\033[2A"
}

up_line() {
  printf "\033[$1A"
}

break_line() {
  printf "\n"
}
