export PS1="\[\e[0;32m\]\u \[\e[0;37m\]@ \[\e[0;36m\]\H \[\e[0;37m\][ \[\e[0;37m\]\# \[\e[0;37m\]] \[\e[0;33m\]\w \[\e[0;37m\]: \[\e[0m\]"

# Add PATH variable
export PATH="/usr/local/sbin:$PATH"
export PYTHONPATH="/tmp/"

# Add Bash Aliases

alias fixgc='./multirunner.py -t command -c "apt-get install --reinstall clearwater-jvmwatcher && service tomcat restart && service telegraf restart" -s -P -w'
alias servicerrestart='multirunner.py -t command -c "servicer restart" -s -w -P -q'
alias tomcatrestart='multirunner.py -t command -c "service tomcat restart" -s -w -P -q'
alias runpuppet='multirunner.py -t runpuppet -s -w -P -q'
alias cleanlogging='multirunner.py -t command -c "find /var/log/logstash/ -type f -mtime +30 -exec rm -f {} + && truncate -s 5G /var/log/elasticsearch/elasticsearch.log" -s -w -P -q'
alias fixreclaimer='./multirunner.py -t command -c "pip install --index-url=https://artifactory.arbfund.com/api/pypi/python-all/simple/ --upgrade --force-reinstall reclaimer-agent && stop reclaimeragent && start reclaimeragent" -s -P -w'
alias ls='ls -G'
