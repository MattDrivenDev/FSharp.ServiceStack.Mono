# Service Stack, with F# on Linux - with mysql

A solution template to quickly help get up and running with [Service Stack](http://www.servicestack.net/) using [F#](http://fsharp.org/). Code is built using [FAKE](http://fsharp.github.io/FAKE/) and deployed to a local [Ubuntu Server](http://www.ubuntu.com/server) via [Vagrant](http://www.vagrantup.com/) - where it runs on [mono fastcgi and nginx](http://www.mono-project.com/FastCGI_Nginx)...

Phew!

## 'with mysql'

This branch of the repository uses a MySql database, which is provisioned using the same `puppet` scripts - the deployment of the database objects is done using the `shell` provisioner (configured in the `VagrantFile`). Communication with the MySql database uses standard `ADO.NET` with the [FsSql](https://github.com/mausch/FsSql) F# wrapper - via the official [MySql Connector/Net](http://dev.mysql.com/downloads/connector/net/). Both are pulled in via NuGet packages.

## Instructions

You'll need to ensure that you have [Oracle Virtual Box](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) installed first. Plus obviously some **.NET** and **F#** development tools/libraries. 

1. Clone this repo, and navigate to the working directory
2. Checkout this branch: `git checkout with_mysql`.
3. Ensure that the puppet modules are brought in (through git submodules): `git submodule init` and then `git submodule update`.
4. From a command line, run `fake build` - this will install any dependencies using nuget and then build the service and copy it into the `www/` directory.
5. From a command line, run `vagrant up` - this will provision you a local Ubuntu Server and use the Puppet scripts to set everything up. Your `www/` directory is shared with the new virtual machine, which is where the application runs from.
6. Navigate to `localhost:8080` in your browser to test.

In theory, everything will work a treat (works on my machine, haha).

At the moment, the only way to see the additions to the database is to remote into the vagrant machine using `vagrant ssh` and use `mysql` to go query the database. Maybe I'll change the service to prove data persistance instead.

## Thanks

* [pipe-devnull](http://pipe-devnull.com/) for some help with provisioning mono fastcgi with the correct user.

