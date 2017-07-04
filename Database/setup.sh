#!/bin/bash
set -e

/etc/init.d/mysql start
sleep 10s
mysqladmin processlist -u root -p"" create "ussd"
sleep 10s
/etc/init.d/mysql stop