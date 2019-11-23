# Introduction
The project aimed to create an container-image that Prestashop 1.7 (or later) is ready to install.

This is because the offical [container image](https://hub.docker.com/r/prestashop/prestashop) is not installable :'( .
It is always return error during the installation.

# Usage
1. Clone the repository into local (e.g.: ~/workspaces/kenson.prestashop);

2. Download the latest [Prestashop](https://www.prestashop.com/) from websites, and extract it into bin folder (e.g.: ~/workspaces/kenson.prestashop/bin);

3. Open the terminal in the repository folder;

4. Execte the following command:
```bash
docker build -t some-prestashop:latest .
```
5. Create the docker network;
```bash
docker network create prestashop-net
```

6. Execute the MySQL container
```bash
docker run --name some-mysql --network prestashop-net -e MYSQL_ROOT_PASSWORD=adminpass -p 3307:3306 -d mysql:8 mysqld --default-authentication-plugin=mysql_native_password
```

7. Execute the Prestashop container
```bash
docker run -d --name some-prestashop --network prestashop-net -p 8000:80 some-prestashop:latest
```

8. Open the [localhost:8000](http://localhost:8000) and finish the installation;

9. Delete the install folder in image;
```bash
docker exec -it some-prestashop rm -rf /usr/share/nginx/html/install
```

10. [Optional] Stop the Prestashop container and commit it;
```bash
docker stop some-prestashop
docker commit some-prestashop myregistry/my-prestashop:latest
```
