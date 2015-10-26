# Developed by Romel Vera
# http://www.github.com/romelsan
# MIT License
# Tested on Python 3.5

import subprocess
import csv
import platform
import colorama # pip install colorama
from colorama import Fore, Back, Style
colorama.init()

#FUNCTIONS
def ping(hostname):
    if platform.system() == "Windows":
        p = subprocess.Popen('ping ' + hostname + " -n 1", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    else:
        p = subprocess.Popen('ping -c 1 ' + hostname, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    pingStatus = 'ok';
        
    for line in p.stdout:
        output = line.rstrip().decode('UTF-8')
 
        if (output.endswith('unreachable.')) :
            #No route from the local system. Packets sent were never put on the wire.
            pingStatus = 'unreachable'
            break
        elif (output.startswith('Ping request could not find host')) :
            pingStatus = 'host_not_found'
            break
        if (output.startswith('Request timed out.')) :
            #No Echo Reply messages were received within the default time of 1 second.
            pingStatus = 'timed_out'
            break
        #end if
    #endFor
    
    return pingStatus
#endDef    


def printPingResult(hostname):
    statusOfPing = ping(hostname)
    
    if (statusOfPing == 'host_not_found') :
        print(Fore.WHITE + Back.RED + hostname + " Host not found" + Style.RESET_ALL)
    elif (statusOfPing == 'unreachable') :
        print(Fore.WHITE + Back.RED + hostname + " Unreachable" + Style.RESET_ALL)
    elif (statusOfPing == 'timed_out') :
        print(Fore.WHITE + Back.RED + hostname + " Timed Out" + Style.RESET_ALL)
    elif (statusOfPing == 'ok') :
        print(Fore.GREEN + hostname + " OK" + Style.RESET_ALL)
    #endIf
#endPing

#END FUNCTIONS

#CODE MAIN
file = open('servers.txt')

try:
    reader = csv.reader(file)
    
    for item in reader:
        printPingResult(item[0].strip())
    #endFor
finally:
    file.close()
#endTry
