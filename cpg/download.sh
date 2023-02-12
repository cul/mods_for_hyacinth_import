#!/bin/bash
for id in `cat ids.log`; do
	filename=${id/\:/_}
	url="https://dlc.library.columbia.edu/catalog/${id}/mods?type=download"
	curl "$url" > "$filename.xml"
done