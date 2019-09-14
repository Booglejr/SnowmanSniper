#!/bin/sh
cd src
zip -9 -r SnowmanSniper.love .
mkdir ../build
mv SnowmanSniper.love ../build
cd ..
cp ./build/SnowmanSniper.love ./build_extras/SnowmanSniper.app/Contents/Resources/
cp ./build_extras/SnowmanSniper.app/ ./build/SnowmanSniper.app
cd ./build_extras
zip -9 -ry SnowmanSniper-osx.zip SnowmanSniper.app
mv SnowmanSniper-osx.zip ../build
