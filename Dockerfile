
# Usar una imagen base de Tomcat 8 con JDK
FROM tomcat:8.5-jdk8

# Definir el directorio donde irá la aplicación JSP
WORKDIR /usr/local/tomcat/webapps/
COPY ./WebContent /usr/local/tomcat/webapps/EpsCuritas/
COPY ./WebContent/WEB-INF/lib/mysql-connector-j-9.0.0.jar /usr/local/tomcat/lib/
COPY ./WebContent/Img/Logo.png /usr/local/tomcat/webapps/EpsCuritas/Img/

# Exponer el puerto 8080 para acceder a la aplicación
EXPOSE 8080

# Comando de inicio de Tomcat
CMD ["catalina.sh", "run"]
