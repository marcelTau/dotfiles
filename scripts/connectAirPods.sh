#!/bin/bash

# old id: E4:90:FD:9B:AD:CE
id="58:64:C4:E7:F1:B0"

bluetoothctl disconnect $id & 
sleep 1
bluetoothctl connect $id & 
