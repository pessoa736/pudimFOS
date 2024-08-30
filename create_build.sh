

#!/bin/bash

# Definir a base do nome do arquivo
basename="release"
dir="./build"
ext=".lua"

# Encontrar o próximo número disponível
i=1
while [ -e "$dir/$basename$i$ext" ]; do
  i=$((i + 1))
done

# Criar o novo arquivo de release com o próximo número disponível
output_file="$dir/$basename$i$ext"

# Concatenar os arquivos no novo arquivo
sudo cat "./main.lua" "./system/PDS.lua" "./system/PSPU.lua" "./system/PVB.lua" "./system/ROMMUPS.lua" > "$output_file"

echo "Arquivo gerado: $output_file"

