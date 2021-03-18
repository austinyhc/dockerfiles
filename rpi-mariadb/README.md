# MariaDB on Raspberry Pi / ARM
### Reference
-	[`10.3-ubuntu` (*Dockerfile*)](https://github.com/Tob1asDocker/rpi-mariadb/blob/master/ubuntu.armhf.10_3.Dockerfile) (on [Ubuntu](https://packages.ubuntu.com/search?arch=armhf&searchon=names&keywords=mariadb-server-10.3) 20.04 LTS Focal Fossa)

# What is MariaDB?
MariaDB Server is one of the most popular database servers in the world. It’s made by the original developers of MySQL and guaranteed to stay open source. Notable users include Wikipedia, DBS Bank and ServiceNow.
The intent is also to maintain high compatibility with MySQL, ensuring a library binary equivalency and exact matching with MySQL APIs and commands. MariaDB developers continue to develop new features and improve performance to better serve its users.B?

### How to use?
```bash
docker run --name some-mariadb -v $(pwd)/mariadb:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=my-secret-pw -d tobi312/rpi-mariadb:TAG
```
Please see official MariaDB images for more details.

#### Docker-Compose

```yaml
version: '2.4'
services:
  mariadb:
    image: tobi312/rpi-mariadb:TAG
    #container_name: mariadb
    restart: unless-stopped
    volumes:
      - ./mariadb:/var/lib/mysql
    environment:
      TZ: Europe/Berlin
      #MYSQL_RANDOM_ROOT_PASSWORD: "yes"
      MYSQL_ROOT_PASSWORD: my-secret-pw
      MYSQL_DATABASE: user
      MYSQL_USER: user
      MYSQL_PASSWORD: my-secret-pw
    ports:
      - 3306:3306
    healthcheck:
      test:  mysqladmin ping -h 127.0.0.1 -u root --password=$$MYSQL_ROOT_PASSWORD || exit 1
      #test:  mysqladmin ping -h 127.0.0.1 -u $$MYSQL_USER --password=$$MYSQL_PASSWORD || exit 1
      interval: 60s
      timeout: 5s
      retries: 5
      #start_period: 30s
```
