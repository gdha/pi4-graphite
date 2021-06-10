#!/bin/sh

set -e

echo "#######################################"
echo "# Preparing Graphite django_admin.exp #"
echo "#######################################"
if [  -f /run/secrets/GRAPHITE_ADMIN_PWD ]; then
   GRAPHITE_ADMIN_PWD=`/usr/bin/head -n 1 /run/secrets/GRAPHITE_ADMIN_PWD`
   export  GRAPHITE_ADMIN_PWD
fi
sed -i "s#\GRAPHITE_ADMIN_MAIL#$GRAPHITE_ADMIN_MAIL#g" /opt/graphite/bin/django_admin_init.exp
sed -i "s#\GRAPHITE_ADMIN_PWD#$GRAPHITE_ADMIN_PWD#g"   /opt/graphite/bin/django_admin_init.exp
sed -i "s#\GRAPHITE_ADMIN_USER#$GRAPHITE_ADMIN_USER#g" /opt/graphite/bin/django_admin_init.exp

echo "#####################"
echo "# Starting Graphite #"
echo "#####################"

## Inspired from the script found at
##   https://sanjeevan.co.uk/blog/running-services-inside-a-container-using-runit-and-alpine-linux/

shutdown() {
echo "###########################"
echo "# shutting down container #"
echo "###########################"

  # first shutdown any service started by runit
  for _srv in $(ls -1 /etc/service); do
    sv force-stop $_srv
  done

echo "#############################"
echo "# shutdown runsvdir command #"
echo "#############################"
  # shutdown runsvdir command
  kill -HUP $RUNSVDIR
  wait $RUNSVDIR

echo "###############################"
echo "# Give processes time to stop #"
echo "###############################"
  # give processes time to stop
  sleep 0.5

echo "##################"
echo "# kill processes #"
echo "##################"
  # kill any other processes still running in the container
  for _pid  in $(ps -eo pid | grep -v PID  | tr -d ' ' | grep -v '^1$' | head -n -6); do
    timeout -t 5 /bin/sh -c "kill $_pid && wait $_pid || kill -9 $_pid"
  done
  exit
}

. /opt/graphite/bin/activate

PATH="${PATH}:/usr/local/bin"

echo "###############################"
echo "# run all scripts in run_once #"
echo "###############################"
# run all scripts in the run_once folder
[ -d /etc/run_once ] && /bin/run-parts /etc/run_once

echo "#############################"
echo "# check services to disable #"
echo "#############################"
## check services to disable
for _srv in $(ls -1 /etc/service); do
    eval X=$`echo -n $_srv | tr [:lower:]- [:upper:]_`_DISABLED
    [ -n "$X" ] && touch /etc/service/$_srv/down
done

echo "#####################"
echo "# remove stale pids #"
echo "#####################"
# remove stale pids
find /opt/graphite/storage -maxdepth 1 -name '*.pid' -delete

exec runsvdir -P /etc/service &

RUNSVDIR=$!
echo "Started runsvdir, PID is $RUNSVDIR"
echo "wait for processes to start...."

sleep 5
for _srv in $(ls -1 /etc/service); do
    sv status $_srv
done

echo "##########################"
echo "# catch shutdown signals #"
echo "##########################"
# catch shutdown signals
trap shutdown SIGTERM SIGHUP SIGQUIT SIGINT
wait $RUNSVDIR

shutdown

