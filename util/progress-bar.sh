#!/bin/bash
function progress_bar() {
  # show first progress_bar
  show_bar

  if [ -z "$progress_bar_log_file" ]; then
    progress_bar_log_file="progress.txt"
  fi
  echo >"$path_sh/log/$progress_bar_log_file"

  if test -n "$1"; then
    echo "Read from positional argument $1"
  elif test ! -t 0; then
    # echo "Read from stdin if file descriptor /dev/stdin is open"
    while read ab; do
      teste=$(echo $ab | grep -P "\[([0-9]+)\/([0-9]+)\].*")
      regex='\[([0-9]+)\/([0-9]+)\].*'
      [[ "$ab" =~ \[([0-9]+)\/([0-9]+)\].* ]] && {
        quantity=${BASH_REMATCH[1]}
        total=${BASH_REMATCH[2]}
        print_bar $quantity $total
      }
      echo "$ab" >>"$path_sh/log/$progress_bar_log_file"
    done
  else
    echo "No standard input."
  fi
  break_line
}

# Vamos dar uma olhada neste script:

# O primeiro uso condicional de test , com o parâmetro -n , verifica se o comprimento do argumento posicional é maior que zero.
# O segundo uso condicional de test , com o parâmetro -t , verifica se o descritor de arquivo de entrada padrão está aberto em um terminal.
# O bloco else confirma que não houve entrada padrão.

lenght_bar=90
loadded=
in_loading=
for i in $(seq 1 $lenght_bar); do
  loadded+=" "
  in_loading+="_"
done

show_bar() {
  printf "[$in_loading]"
  return_car
  # break_line
}

index_progress_bar=0
progress_bar_array[0]=0
print_bar() {
  percent=$((($1 * 100) / $2))
  percent_bar=$((($percent * $lenght_bar) / 100))
  # $(echo "scale=2;($1*$lenght_bar)" | bc | sed -r "s/\.[0-9]+//")

  # if the current progress_bar is equal to 100
  if [ ${progress_bar_array[$index_progress_bar]} -eq 100 ]; then
    # increment the amount of progress_bar
    index_progress_bar=$(expr $index_progress_bar + 1)
    # show new line and new progress_bar
    break_line
    show_bar
  fi

  progress_bar_array[$index_progress_bar]=$percent

  return_car
  printf "\033[1C\033[07m${loadded:0:$percent_bar}\033[0m"

  return_car
  printf "\033[${lenght_bar}C"
  printf "\033[3C"
  printf "\033[K"
  printf "$percent%% "

}
