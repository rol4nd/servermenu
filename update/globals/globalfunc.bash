#!/usr/bin/env bash

echotext()
{
        echo -e "${!2}$1${RCol}"
}

echospaceline()
{
        for((i=0;i<$1;i++))
        do
                echo " "
        done
}