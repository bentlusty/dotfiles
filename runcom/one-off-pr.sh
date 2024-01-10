#!/bin/bash
forter feature create -n $1
git commit -am $1
forter feature pr
