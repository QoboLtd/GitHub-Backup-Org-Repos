GitHub-Backup-Org-Repos
=======================

Quick Perl script to clone/pull organization's repositories from GitHub

Install
-------

After cloning the repository, create your configuration file, 
based on the example:

```
$ cp .env.example .env
$ vim .env
```

Usage
-----

Import configuration variables and run the script:

```
$ source .env
$ ./fetch-repos.pl
```

*NOTE* You have to import .env file every time you change it for the new
settings to take effect.

TODO
----
[x] Backup all repositories of organization
[x] Backup multiple organizations into different folders
[ ] Support backup from other sources, like BitBucket

