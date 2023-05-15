if command -v code >/dev/null 2>&1; then
  export EDITOR='code -w'
elif command -v subl >/dev/null 2>&1; then
  export EDITOR='subl -w'
elif command -v mvim >/dev/null 2>&1; then
  export EDITOR='mvim -f'
elif command -v vim >/dev/null 2>&1; then
  export EDITOR='vim -w'
fi
