# Kubernetes yaml files for the graphite pod on PI4

```bash
$ kubectl apply -f ./graphite-namespace.yaml 
namespace/graphite created

$ kubectl apply -f ./graphite-secret.yaml
secret/graphite created

$ kubectl apply -f ./ghcr-secret.yaml 
secret/dockerconfigjson-github-com created

$ kubectl apply -f ./persistentvolumeclaim-graphite.yaml
persistentvolumeclaim/graphite created

$ kubectl apply -f ./statefulset_graphite.yaml 
statefulset.apps/graphite created

$ kubectl apply -f ./service_graphite.yaml 
service/graphite-svc created

$ kubectl get svc -n graphite
NAME           TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)                       AGE
graphite-svc   NodePort   10.43.56.145   <none>        80:30080/TCP,2003:32003/TCP   99s

$ kubectl logs -n graphite graphite-0
#######################################
# Preparing Graphite django_admin.exp #
#######################################
#####################
# Starting Graphite #
#####################
###############################
# run all scripts in run_once #
###############################
#############################
# check services to disable #
#############################
#####################
# remove stale pids #
#####################
Started runsvdir, PID is 49
wait for processes to start....
/usr/sbin/crond 4.5 dillon's cron daemon, started with loglevel notice
find: ‘/var/log/graphite’: No such file or directory
25 Jan 09:45:52 - [66] reading config file: /opt/statsd/config/udp.js
25 Jan 09:45:52 - server is up INFO
Starting carbon-cache (instance a)
25/01/2023 09:45:54 :: [console] Using sorted write strategy for cache
25/01/2023 09:45:54 :: [console] twistd 22.10.0 (/opt/graphite/bin/python3 3.9.13) starting up.
25/01/2023 09:45:54 :: [console] reactor class: twisted.internet.epollreactor.EPollReactor.
Starting carbon-aggregator (instance a)
25/01/2023 09:45:54 :: [console] Using sorted write strategy for cache
25/01/2023 09:45:54 :: [aggregator] reading new aggregation rules from /opt/graphite/conf/aggregation-rules.conf
25/01/2023 09:45:54 :: [aggregator] clearing aggregation buffers
25/01/2023 09:45:54 :: [clients] connecting to carbon daemon at 127.0.0.1:2004:None
25/01/2023 09:45:54 :: [console] twistd 22.10.0 (/opt/graphite/bin/python3 3.9.13) starting up.
25/01/2023 09:45:54 :: [console] reactor class: twisted.internet.epollreactor.EPollReactor.
25/01/2023 09:45:54 :: [console] ServerFactory starting on 7002
25/01/2023 09:45:54 :: [console] Starting factory <twisted.internet.protocol.ServerFactory object at 0xffff8f7d1af0>
25/01/2023 09:45:54 :: [console] Installing SIG_IGN for SIGHUP
25/01/2023 09:45:54 :: [console] CarbonReceiverFactory starting on 2003
25/01/2023 09:45:54 :: [console] Starting factory <carbon.protocols.CarbonReceiverFactory object at 0xffff8f54ddc0>
25/01/2023 09:45:54 :: [console] CarbonReceiverFactory starting on 2004
25/01/2023 09:45:54 :: [console] Starting factory <carbon.protocols.CarbonReceiverFactory object at 0xffff8f74aca0>
25/01/2023 09:45:54 :: [console] Installing SIG_IGN for SIGHUP
25/01/2023 09:45:54 :: [console] Starting factory CarbonClientFactory(127.0.0.1:2004:None)
25/01/2023 09:45:54 :: [clients] CarbonClientFactory(127.0.0.1:2004:None)::startedConnecting (127.0.0.1:2004)
25/01/2023 09:45:54 :: [console] CarbonReceiverFactory starting on 2023
25/01/2023 09:45:54 :: [console] Starting factory <carbon.protocols.CarbonReceiverFactory object at 0xffff88f1cbb0>
25/01/2023 09:45:54 :: [console] CarbonReceiverFactory starting on 2024
25/01/2023 09:45:54 :: [console] Starting factory <carbon.protocols.CarbonReceiverFactory object at 0xffff88dc5940>
25/01/2023 09:45:54 :: [clients] CarbonClientProtocol(127.0.0.1:2004:None)::connectionMade
25/01/2023 09:45:54 :: [clients] CarbonClientFactory(127.0.0.1:2004:None)::connectionMade (CarbonClientProtocol(127.0.0.1:2004:None))
25/01/2023 09:45:54 :: [clients] Destination is up: 127.0.0.1:2004:None
25/01/2023 09:45:54 :: [listener] MetricPickleReceiver connection with 127.0.0.1:59352 established
down: brubeck: 1s, normally up, want up
run: carbon: (pid 72) 5s; run: log: (pid 70) 5s
run: carbon-aggregator: (pid 68) 5s; run: log: (pid 67) 5s
down: carbon-relay: 1s, normally up, want up; run: log: (pid 77) 5s
down: collectd: 1s, normally up, want up
run: cron: (pid 65) 5s
down: go-carbon: 1s, normally up, want up
Migrations for 'account':
  /opt/graphite/webapp/graphite/account/migrations/0002_auto_20230125_0945.py
    - Alter field history on profile
run: graphite: (pid 69) 5s
run: nginx: (pid 71) 5s
Migrations for 'events':
  /opt/graphite/webapp/graphite/events/migrations/0002_auto_20230125_0945.py
    - Alter field tags on event
down: redis: 1s, normally up, want up
run: statsd: (pid 66) 5s; run: log: (pid 64) 5s
##########################
# catch shutdown signals #
##########################
Operations to perform:
  Apply all migrations: auth
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
25/01/2023 09:46:02 :: [listener] MetricLineReceiver connection with 127.0.0.1:44578 established
25/01/2023 09:46:02 :: [listener] MetricLineReceiver connection with 127.0.0.1:44578 closed cleanly
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
Operations to perform:
  Synchronize unmigrated apps: browser, composer, functions, messages, metrics, render, staticfiles, whitelist
  Apply all migrations: account, admin, auth, contenttypes, dashboard, events, sessions, tagging, tags, url_shortener
Synchronizing apps without migrations:
  Creating tables...
    Running deferred SQL...
Running migrations:
  Applying account.0001_initial... OK
25/01/2023 09:46:12 :: [listener] MetricLineReceiver connection with 127.0.0.1:33350 established
25/01/2023 09:46:12 :: [listener] MetricLineReceiver connection with 127.0.0.1:33350 closed cleanly
  Applying account.0002_auto_20230125_0945... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying dashboard.0001_initial... OK
  Applying events.0001_initial... OK
  Applying events.0002_auto_20230125_0945... OK
  Applying sessions.0001_initial... OK
  Applying tagging.0001_initial... OK
  Applying tagging.0002_on_delete... OK
  Applying tagging.0003_adapt_max_tag_length... OK
  Applying tags.0001_initial... OK
  Applying url_shortener.0001_initial... OK
25/01/2023 09:46:22 :: [listener] MetricLineReceiver connection with 127.0.0.1:50670 established
25/01/2023 09:46:22 :: [listener] MetricLineReceiver connection with 127.0.0.1:50670 closed cleanly
ok: run: nginx: (pid 71) 39s
```

# info about secrets:
https://stackoverflow.com/questions/61912589/how-can-i-use-github-packages-docker-registry-in-kubernetes-dockerconfigjson

