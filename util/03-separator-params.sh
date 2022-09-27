#!/bin/bash

# separates the parameters that come after the -y flag from the parameters that
# come after the -n flag
# parses the $separator_y_n_params_ variable as an array
separator_y_n_params() {
  unset toogle_y_n

  index_true=0
  unset params_y

  index_false=0
  unset params_n

  last_i=$(expr ${#separator_y_n_params_[@]} - 1)
  for i in $(seq 0 $last_i); do
    value=${separator_y_n_params_[$i]}

    if [[ $value =~ ^-[yn]$ ]]; then
      toogle_y_n=$value

    elif [ "$toogle_y_n" == "-y" ]; then
      params_y[$index_true]=$value
      index_true=$(expr $index_true + 1)

    elif [ "$toogle_y_n" == "-n" ]; then
      params_n[$index_false]=$value
      index_false=$(expr $index_false + 1)

    fi

  done
  # For tests
  # echo "PARAMS Y ~${params_y[@]}"
  # echo "PARAMS N ~${params_n[@]}"
}
