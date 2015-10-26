# Monitor Host
Monitor Host by ping command    
Bash and Python 3 version    

#### Features
- [x] Ping the server and show OK or Down status
- [x] The Bash version can log to a file and alert via email

### Requirements
For python 3 version install colorama type this on shell:    
`pip install colorama`

### Basic Usage
Download it    
Check variable options inside "monitorHost.sh": add servers, set alert modes on or off    
For Python 3 version just add the servers to the file "servers.txt"    
You can add the bash version to a Cron     
`For Example:

In order to run this script every 10 minutes (or as per your requirements), you need to install a script as cron job:
$ chmod +x /path/to/monitorHost.sh

Install the monitorHost script as crontab using the editor:
$ crontab -e

Append the following cronjob entry:
# Monitor remote host every 10 minutes using monitorHost
10 * * * * /home/vivek/bin/monitorHost.sh`

### Built using
* Python 3.5 - [Link](https://www.python.org/)
* Bash

### Tested on:
Python 3.4 and 3.5    
Ubuntu 14.04 LTS

### TO DO
- Nothing yet...

### License
MIT License

### Contact
twitter @RomelSan