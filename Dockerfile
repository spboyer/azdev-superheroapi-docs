FROM swaggerapi/swagger-ui

MAINTAINER spboyer

# copy swagger files to the `/js` folder
ADD ./dist/* /usr/share/nginx/html/

EXPOSE 8080
