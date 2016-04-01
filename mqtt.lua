------------------------------------------
--- Author: Pradeep Singh
--- Date: 25th March 2016
--- Version: 1.0
--- NodeMCU Firmware: nodemcu_float_0.9.6-dev_20150704.bin
--- Description: This is sample code for sending and receiving messages on MQTT
------------------------------------------

------------------------------------------
--- Set Variables ---
------------------------------------------
MQTT_BROKER = "iot.eclipse.org"
MQTT_BROKER_PORT = 1883
MQTT_BROKER_SECURE = 0

MQTT_PUBLISH_TOPIC = "my_topic"
MQTT_PUBLISH_TOPIC_QoS = 0
MQTT_PUBLISH_TOPIC_RETAIN = 0
MQTT_PUBLISH_MESSAGE = "Hello MQTT"

MQTT_SUBSCRIBE_TOPIC =  "my_topic"
MQTT_SUBSCRIBE_TOPIC_QoS = 0

MQTT_CLIENT_ID = "client1"
MQTT_CLIENT_USER = "username"
MQTT_CLIENT_PASSWORD = "password"
MQTT_CLIENT_KEEPALIVE_TIME = 120
------------------------------------------



--- Initiate MQTT Client ---
mqtt = mqtt.Client(MQTT_CLIENT_ID, MQTT_CLIENT_KEEPALIVE_TIME, MQTT_CLIENT_USER, MQTT_CLIENT_PASSWORD)


--- On Connect Event ---
mqtt:on("connect", function(con) 
     print ("connected") 
end)


--- Offline Event ---
mqtt:on("offline", function(con) 
     print ("offline") 
end)


-- On Message Recieve Event ---
-- This Function will be invoked everytime Broker sends message to subscribed Topic ---
mqtt:on("message", function(conn, topic, data)
  print("MQTT Message Received...")
  print("Topic: " .. topic)
  if data ~= nil then
    print("Message: " .. data)
  end
end)


--- Connect to MQTT Broker ----
mqtt:connect(MQTT_BROKER, MQTT_BROKER_PORT, MQTT_BROKER_SECURE, function(conn) 
  print("connected")
end)


-- Subscribe to MQTT Topic ---
mqtt:subscribe(MQTT_SUBSCRIBE_TOPIC,MQTT_SUBSCRIBE_TOPIC_QoS, function(conn) 
end)

  
-- Publish to MQTT Topic ---
-- Use this Function to publish message on MQTT Topic ---
mqtt:publish(MQTT_PUBLISH_TOPIC, MQTT_PUBLISH_MESSAGE, MQTT_PUBLISH_TOPIC_QoS, MQTT_PUBLISH_TOPIC_RETAIN, function(conn) 
  print("Message Published on MQTT Topic...") 
end)
