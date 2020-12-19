#!/bin/bash 
 
# script file for BASH 
# which bash
# save this file as g.sh
# chmod +x g.sh
# ./g.sh
# checked in https://www.shellcheck.net/

 
# for all ppm files in this directory
#!/bin/bash
for file in *.ppm ; do
  # b is name of file without extension
  b=$(basename "$file" .ppm)
  # convert  using ImageMagic
  convert "${b}".ppm -resize 600x600 "${b}".png
  echo "$file"
done

 
echo OK
# end

