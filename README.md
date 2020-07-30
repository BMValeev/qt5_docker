Скрипты для Сборки QT5 в докер контейнере


Сборка контейнера. В папке с Dockerfile выполнить:


	Заменить строку 32 , так как там мой публичный ключ. 
	docker build --no-cache --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --tag "deploy-qt5:latest" .
	
	
Запуск контейнера:


	docker run -it -d -u root -p3244:22 deploy-qt5
	Он запустится и повиснет на 3244 порту
	
	
Сохранить контенер, чтобы при перезапуске остались скомпилированные версии


	ID=$(docker ps | awk '{if((FNR>1)&&(substr($10,0,4)=="3244")) print $1}')
	docker commit -m "nighty commit" -a "GitlabAutomatical"  $ID deploy-qt5
	
	
Сохранение выполняется по номеру порта, если его меняете команда тоже меняется!	
	
Работа:


Выбор версии qt5. Перейдет на ветку и обновит все подмодули репозитория:


	ssh deploy@#HOSTNAME# -p3244
	./qt5_docker/setQT5V.sh #VERSION#		
#HOSTNAME# -хост где запущен докер
#VERSION# - версия на которую перейти

Загрузка необходимого sysroot. После скачивания необходимо распаковать в папку с удобным именем внутри ~/rootfs:


	scp -p #ROOTFS# deploy@#HOSTNAME#:~/rootfs
#ROOTFS# файл с архивом целевой системы	
#HOSTNAME# -хост где запущен докер	


Сборка. 


        ssh deploy@#HOSTNAME# -p3244
        ./qt5_docker/buildQT.sh #ROOTFS#
#ROOTFS# имя папкп с rootfs	
#HOSTNAME# -хост где запущен докер


