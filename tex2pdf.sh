fileName=${@%.*}

docker run --rm -v `pwd`/:/latex/ extendwings/docker-platex build "$@"

rm ${fileName}.aux
rm ${fileName}.dvi
rm ${fileName}.synctex.gz
rm ${fileName}.log
rm ${fileName}.bbl
rm ${fileName}.blg

