# pi4-graphite

To find the IP address of the host where pod graphite-0 is running on:

```bash
$ kubectl -n graphite describe pod graphite-0 | grep -i node: | cut  -d/ -f2
192.168.0.205

$ SERVER=$(kubectl -n graphite describe pod graphite-0 | grep -i node: | cut  -d/ -f2)
$ echo "carbon.test.diceroll 5 $(date +%s)" | nc $SERVER 2003 
```

Open a browser with URL http:$SERVER:30080 to see the result of the tests:

