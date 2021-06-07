clean:
	rm -rf sprites build icons/us_* rebusurance.zip overpass.zip

rebusurance.zip:
	wget -q -O rebusurance.zip https://github.com/1ec5/rebusurance/releases/download/v1.0.0/rebusurance-v1.0.0.zip

build/rebusurance-v1.0.0: rebusurance.zip
	unzip -q rebusurance.zip "*/image2d/*.svg" -d build

sprites: build/rebusurance-v1.0.0
	scripts/import_rebusurance.sh
	mkdir -p sprites
	npx spritezero sprites/sprite@2x icons/ --retina
	npx spritezero sprites/sprite icons/

code_format:
	npx prettier --write .

run: sprites
	python3 -m http.server 1776

overpass.zip:
	wget -q -O overpass.zip https://github.com/RedHatOfficial/Overpass/releases/download/3.0.2/overpass-desktop-fonts.zip

build/overpass: overpass.zip
	unzip -q overpass.zip "overpass/*.otf" -d build

fonts: build/overpass
	mkdir -p fonts
	scripts/build_fonts.sh
