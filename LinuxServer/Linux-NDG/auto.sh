#!/bin/bash

git add index.html
git nota "Main page"
git sube

read -p "¿Qué capítulo es? " ch
git add chapters/.
git nota "CoronaLinux - NDG Linux $ch"
git sube

git add assets/.
git nota "Folder assets"
git sube

git add README.md
git nota "Linux Certification"
git sube

git add images/.
git nota "Images"
git sube

git add auto.sh
git nota "Script de automatización del sistema"
git sube
