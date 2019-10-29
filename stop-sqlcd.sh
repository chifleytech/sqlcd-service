#!/usr/bin/env bash
kill -15 $(ps aux | grep '[c]om.chifleytech.app=sqlcd' | awk '{print $2}')