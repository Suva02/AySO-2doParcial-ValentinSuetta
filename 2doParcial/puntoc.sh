- cd UTN-FRA_SO_Docker/
- cd ejemplo2
- mkdir  -p appHomeBanking/index.html appHomeBanking/contacto.html 
- vim dockerfile:
	FROM nginx
	COPY appHomeBanking /usr/share/nginx/html

- docker login -u suva02 -> logeo en docker
- docker build -t suva02/2parcial-ayso:v1.0 . -> construccion de la imagen
- docker image ls -> ver imagen creada
- docker push suva02/2parcial-ayso:v1.0 -> subir la imagen a docker
- docker run -d -p 8080:80 suva02/2parcial-ayso:v1.0 -> desplegar la imagen
- docker container ls -> ver si esta corriendo

VER SU FUNCIONAMIENTO EN LA WEB
http://192.168.56.3:8080/index.html
http://192.168.56.3:8080/contacto.html


NOMBRE DEL CONTENEDOR PARA BUSCAR EN DOCKER -> suva02/2parcial-ayso:v1.0
