#!/bin/bash

APIC_URL="$1"
USERNAME="admin"
PASSWORD="C1sco12345"

echo "Resetting QoS configuration on $APIC_URL..."

# Login
curl -sk -X POST "$APIC_URL/api/aaaLogin.json" \
  -H "Content-Type: application/json" \
  -d "{\"aaaUser\":{\"attributes\":{\"name\":\"$USERNAME\",\"pwd\":\"$PASSWORD\"}}}" \
  -c apic-cookie.txt

# Reset QoS Class Level2 config (Tail-drop + PFC disabled)
curl -sk -X POST "$APIC_URL/api/node/mo/uni.xml" \
  -H "Content-Type: application/xml" \
  -d '<qosClass admin="enabled" dn="uni/infra/qosinst-default/class-level2" prio="level2">
         <qosCong algo="tail-drop" ecn="disabled"/>
         <qosPfcPol name="default" adminSt="no" noDropCos="" enableScope="fabric"/>
       </qosClass>' \
  -b apic-cookie.txt

echo "Reset complete."

