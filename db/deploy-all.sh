#!/bin/bash
# 1. List of .txt files containing sql to execute on the servicestackdb.
mysql --user=servicestack --password=servicestackpw servicestackdb < /vagrant/db/0001-0.1.0/0001-create-table-helloworld.txt
