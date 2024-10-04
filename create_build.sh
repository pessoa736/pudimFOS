

#!/bin/bash

basename="release"
dir="./build"
ext=".lua"

echo  "ecreva o tipo da build (TIC80 ...)"
read -r build

if [ ! -d "$dir/$build" ]; then
    mkdir -p "$dir/$build"
    echo "Diretório criado: $dir/$build"
fi

id=1
while [ -e "$dir/$build/$basename$i$ext" ]; do
  id=$((id + 1))
done


output_file="$dir/$build/$basename$id$ext"

if [ "$build"="TIC80" ] || [ "$build"="tic80" ]; then

  sudo cat "./system/PDS(TIC80).lua" "./system/PSPU(TIC80).lua" "./system/PVB(TIC80).lua" "./system/ROMMUPS(TIC80).lua" "./main(TIC80).lua" > "$output_file"

fi

echo "Arquivo gerado: $output_file"

