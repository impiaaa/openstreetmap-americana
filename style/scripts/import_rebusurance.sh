#!/bin/bash

find "build/rebusurance-v1.0.0/image2d" -name "*.svg" -type f -print0 | while read -d $'\0' f; do
  newfile=`echo "$f" | sed -e 's/ /_/g; s/U.S./us/g'`
  mv -n "$f" "$newfile";
done

for i in $( ls build/rebusurance-v1.0.0/image2d/ | grep [A-Z] );
do
  #Remove text placeholder from shields
  sed -e 's/<text.*\/text>//g' "build/rebusurance-v1.0.0/image2d/$i" | \
  \
  #Scale shields to a reasonable size for rasterization
  xmlstarlet sel -N x=http://www.w3.org/2000/svg -I -D -t -e svg -c "//x:svg/@*" -a "width" -o 90 --break -a "height" -o 45 --break -e g -a "transform" -o "scale(0.35,0.35)" --break -c "//x:svg/*" \
  \
  > icons/us_`echo "$i" | tr 'A-Z' 'a-z'`
done


#Customizations

#Make the crown on US Interstate highway shields pointier
xmlstarlet ed -L -N x=http://www.w3.org/2000/svg -u "//x:svg/x:path[@id='interstate-crown']/@transform" --value "scale(0.35,0.70) translate(0,10)" icons/us_interstate.svg
