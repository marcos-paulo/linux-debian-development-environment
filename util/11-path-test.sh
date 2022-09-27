#!/bin/sh
#!/bin/bash

# rustup shell setup
# affix colons on either side of $PATH to simplify matching
test_and_export_path_environment_in_this_shell() {
  case ":${PATH}:" in
  *:"$1":*) ;;

  *)
    # Prepending path in case a system-installed rustc needs to be overridden
    export PATH="$1:$PATH"
    ;;

  esac
}

test_and_export_bin_path_in_shell_rc_file() {
  if [ -z "$(cat $2 | grep -P "$1")" ]; then
    echo "export PATH=\"$1:\$PATH\"" >>$2
  fi
}
