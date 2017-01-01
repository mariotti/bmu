# WARNING this code is at GAMMA stage

Wrong settings can ovewrite your data.

# bmu

BackMeUp - A tool to make backups for personal use and maybe system wide too.

Please forgive me the warning/gamma above. But in principle the risk is real
and for a backup tool "removing your data" might not be the best starting point.
So just be very careful while testing.

The basic idea comes from https://blog.techottis.ch/2016/10/15/backup-with-rsync-a-la-time-machine-a-proof/.

The initial implemetation is here: https://github.com/mariotti/mfsh-scripts/blob/master/bin/backmeup.sh

This repo is a ( or the) starting point for a better implementation and a command line tool which goes
beyond a bare proof of concept.

## Why another backup tool?

I was, and I am still, not happy with all the tools around. Also lately I started to use a light mac
for quick everyday work. My current linux box is even lighter, but inside it looks more like a server
then a quick desktop tool. This made things even worst: sharing a personal backup system within OSs.

But the Mac OS Time Machine was a nice discovery and finding that I can do the same with the
Unix command "rsync" was even better.

## Target Requirements

 - I can bring the backup disk with me, plug it where I want, and still see all my files.

## Discussion

The target requirements are a bit of an utopia but not that far. This is what 'clouds' services
are doing for you for a price. Actually for 2 prices: money and privacy.

I will leave the rest of the discussion for the wiki. This tool indeed has the same target
but, at present, needs you to keep the backup-disk in your pockets.

## Required tools

Your OS, but not yet windows. To create backups it uses the "rsync" command which is simply
common to every Unix alike system: Linux (any version), MacOS (I guess any version),
Unix (any version).

The problem is to retrieve data. Actually the real problem is to find the data quickly.
The data are backed up! Now, how to search? Beside a common 'ls' or 'File Manager'?

A basic indexing tool is "locate" which uses a call to "updatedb" to create an index. This
is also very common within Unix alike OSs. On an up to date Mac OS, you will need indeed the
homebrew version to create the index.

# How it works

 - rsync creates an identical copy of your data and directory structure.
 - rsync with an added option also creates a backup directory with changed files
 - This directory is created with the current date within its name
 - At any run of rsync you create a copy plus a new directory with the changes.
 - To retrieve the files versions, you run locate which gives you the list
   of matching file names plus the "historical"/"backup" list with the same matching
   name.
 - At present the restore is up to you.

## The scripts

 - backmeup.setup.sh You have to edit this for the basic directories
 - backmeup.install.sh Creates the required directories
 - backmeup.sh it backs up your data
 - backmeup.updatedb.sh Creates a search index
 - backmeup.locale.sh is a nice shortcut to locate -d "backupdb"


Firsts scripts are there..
..mm.. docs asap too.
