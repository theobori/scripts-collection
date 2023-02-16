#!/usr/bin/env bash

echo "📦 $(($(docker ps | wc -l) - 1)) (Docker)"
