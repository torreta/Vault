import json
import websocket
import datetime
import time
import sys

channel_id = ''
channel_id = sys.argv[1]
p1="{\"channel\":\"OnlinegameChannel\","
p2="\"gamechannel\":"+channel_id+"}"
p3=p1+p2

msg={}
msg['command']= "subscribe"
msg['identifier']= p3



from websocket import create_connection
ws = create_connection("ws://192.168.0.120:3000/cable")
result = ws.recv()
result = json.loads(result)
print ("Received Conection '%s'" % result)


ws.send(json.dumps(msg))

result = ws.recv()
result = json.loads(result)
print ("Received Subscription '%s'" % result)

p4="{\"mensaje\":\"Hello World "+channel_id+"\","
p5="\"action\":\"update_score\"}"
p6=p4+p5


msg['command']= "message"
msg['data']= p6

count = 0
while (count <= 2):
    ws.send(json.dumps(msg))
    result = ws.recv()
    result = json.loads(result)
    print ("Received Message'%s'" % result)
    time.sleep(2)
    count = count + 1

time.sleep(5)
ws.close()
