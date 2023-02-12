# git clone git@github.com:cul/mods_for_hyacinth_import.git
# cd mods_for_hyacinth_import
if [ "$1" ]; then
  cat modsCollection.head > "$1-mods.xml"
  cat $1/ldpd*.xml | grep -v "?xml version" >> "$1-mods.xml"
  cat modsCollection.foot >> "$1-mods.xml"
  gzip "$1-mods.xml"
else
  echo " no xml directory given!"
  echo "usage: ./collect.sh XML_DIR"
fi