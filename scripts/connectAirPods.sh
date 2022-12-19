#!/bin/bash

bluetoothctl disconnect E4:90:FD:9B:AD:CE & 
sleep 1
bluetoothctl connect E4:90:FD:9B:AD:CE & 
