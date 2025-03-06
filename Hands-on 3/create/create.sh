#!/bin/bash
echo "Hola Mundo" > mytext
cat mytext
mkdir backup
mv mytext backup/
ls -l backup
rm backup/mytext
rmdir backup
