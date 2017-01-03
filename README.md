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
 - You run the indexing script required by locate
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

# Example, Demo

As example I get my other repo "mariotti/freemol" which updates files by simply configuring
and compiling in different directories. For the sake of the example you can do this:

   cd ~
   mkdir tmp
   cd tmp
   git clone https://github.com/mariotti/freemol.git

At present we do not have a real installation then we use a convenient variable.
Please "cd" where you have just cloned the "bmu" repo, something like this:

    cd ~/bmu

(if you have it on your home folder), then:

    export BMU=${PWD}
    
Then "cd" on the containing directory of your project, in our example:

    cd tmp

Now we start the demo.

First install.

    ${BMU}/bin/backmeup.install.sh

The output should be close to:

    mariotti: ~/tmp>ls -altr
    drwxr-xr-x    8 mariotti  staff        272 Jan  3 17:55 freemol/
    drwxr-xr-x    2 mariotti  staff         68 Jan  3 17:58 rsyncBackup-BP/
    drwxr-xr-x    3 mariotti  staff        102 Jan  3 17:58 rsyncBackup/

First Backup (just a mirror of the files):

    ${BMU}/bin/backmeup.sh freemol

At this stage we have a copy of the directory at:

    mariotti: ~/tmp>ls -ald ~/tmp/rsyncBackup/freemol/
    drwxr-xr-x  3 mariotti  staff  102 Jan  3 18:11 /Users/mariotti/tmp/rsyncBackup/freemol//

The other folders are empty. Now we run freemol tools to start a configuration.

    cd freemol/Freemol
    ./config/autoconfigure 
    ./config/configure m_generic_osx gfortran /Users/mariotti/tmp/freemol/Freemol

And we back it up again:

    ${BMU}/bin/backmeup.sh freemol

In my case I see new files in the backup:

    mariotti: ~/bmu>ls -altr ~/tmp/rsyncBackup-BP/freemol/B-20170103-181649/freemol/Freemol/bin/
    total 120
    -rwxr-xr-x  1 mariotti  staff  10680 Jan  3 17:55 makemake.prog*
    -rwxr-xr-x  1 mariotti  staff  10680 Jan  3 17:55 makemake.pmorefiles*
    -rwxr-xr-x  1 mariotti  staff  12541 Jan  3 17:55 makemake.morefiles*
    -rwxr-xr-x  1 mariotti  staff  12541 Jan  3 17:55 makemake*
    -rwxr-xr-x  1 mariotti  staff    663 Jan  3 17:55 cleanup*
    drwxr-xr-x  3 mariotti  staff    102 Jan  3 18:16 ../
    drwxr-xr-x  7 mariotti  staff    238 Jan  3 18:16 ./

The freemol configuration script changed few repository files. This is indeed a but in the
freemol configuration (as this should not happen, It has to "add" them not change), but
we have a backup.

How to search. Make an index first. We run:

    ${BMU}/bin/backmeup.updatedb.sh

Which creates an index to be quickly accessed. Then we search with:

    ${BMU}/bin/backmeup.locate.sh makemake.prog
    ~/tmp/rsyncBackup-BP/freemol/B-20170103-181649/freemol/Freemol/bin/makemake.prog
    ~/tmp/rsyncBackup-BP/freemol/B-20170103-181649/freemol/Freemol/bin/makemake.prog
    ~/tmp/rsyncBackup/freemol/freemol/Freemol/bin/makemake.prog
    ~/tmp/rsyncBackup/freemol/freemol/Freemol/bin/makemake.prog

As I was running this demo "life" (in parallel as writing), I found out only now
the duplicated entries. But at least the basic information is there,
two versions of the files: The copy and the backup.


