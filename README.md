Скрипты для Сборки QT5 в докер контейнере
Выполнение:
Выбор версии qt5. перейдет на ветку и обновит все подмодули репозитория
	ssh deploy@#HOSTNAME# -p3244
	./qt5_docker/setQT5V.sh #VERSION#
#HOSTNAME# -хост где запущен докер
#VERSION# - версия на которую перейти
Загрузка необходимого sysroot. после скачивания необходимо распаковать в папку с удобным именем.
	scp -p #ROOTFS# deploy@#HOSTNAME#:~/rootfs
Сборка. В качестве имени указывается название папки в которой лежит ROOTFS
        ssh deploy@#HOSTNAME# -p3244
        ./qt5_docker/buildQT.sh #ROOTFS#

