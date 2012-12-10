CWD=`pwd`

all: mysql redis memcached mongo

kill: mysql-kill memcached-kill mongo-kill redis-kill

clean:
	rm -rf mongo-db
	rm -rf mysql-db
	rm -rf redis-db

mysql: mysql-db
	@echo "Starting MySQL"
	/usr/local/Cellar/mysql/5.5.27/bin/mysqld \
		--lower_case_table_names=2 \
		--basedir=/usr/local/Cellar/mysql/5.5.27 \
		--datadir=${CWD}/mysql-db \
		--plugin-dir=/usr/local/Cellar/mysql/5.5.27/lib/plugin \
		--log-error=${CWD}/mysql-db/mysql.err \
		--pid-file=${CWD}/mysql.pid &

mysql-db:
	mkdir -p mysql-db
	/usr/local/bin/mysql_install_db \
		--basedir=/usr/local/Cellar/mysql/5.5.27 \
		--datadir=${CWD}/mysql-db

mysql-kill:
	kill `cat mysql.pid`
	rm -f mysql.pid
	@echo "MySQL Server Killed"
	
memcached:
	@echo "Starting Memcached"
	@memcached -dP ${CWD}/memcached.pid

memcached-kill:
	kill `cat memcached.pid`
	rm -f memcached.pid
	@echo "Memcached Killed"

mongo:
	@echo "Starting Mongo DB"
	@mkdir -p mongo-db
	mongod --fork --dbpath mongo-db --pidfilepath ${CWD}/mongo.pid

mongo-kill:
	kill -2 `cat mongo.pid`
	rm -f mongo.pid
	@echo "MongoDB Server Killed"

redis:
	@mkdir -p redis-db
	redis-server redis.conf
	@echo "Starting Redis Server"

redis-kill:
	redis-cli shutdown
	@echo "Redis Server Killed"
