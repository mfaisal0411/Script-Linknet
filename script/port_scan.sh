#!/bin/bash
if lsof -Pi :80 -sTCP:LISTEN; then
	echo "running"
else
	echo "not running"
fi
