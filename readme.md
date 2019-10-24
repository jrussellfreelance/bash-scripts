## Bash Scripts
This is a collection of bash scripts I've written to manage my servers and save time when performing various tasks.  Basically every one of these scripts was written while working with Ubuntu, so keep that in mind.  Also, the scripts related to PHP assume version 7.2.

I have separated the scripts by their general function.  If you inspect any particular script, I give a brief explanation of what the script does.

A lot of the scripts reference files in the `templates` directory in a relative way, i.e. `../templates/php-fpm/phpfpm.conf`, so be aware of that.

Some notable scripts in this repository:

* `topten.sh` script in `system` folder - a script that uses associative arrays to calculate resource usage over a specified amount of time.
* Wordpress instance deployment scripts
* Nginx config generation scripts