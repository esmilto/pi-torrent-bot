#!/usr/bin/env bash

transmission-remote -n username:password -t $1 -i | grep Name: