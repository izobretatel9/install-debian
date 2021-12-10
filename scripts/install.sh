#!/bin/bash
clear
echo "
██████████████████████████████████████████████████████████████████████████████████████████████
█▄─█─▄██▀▄─██▄─▄▄▀█▄─▄█▄─▀█▀─▄█▄─▄█░▄▄░▄█─▄▄─█▄─▄─▀█▄─▄▄▀█▄─▄▄─█─▄─▄─██▀▄─██─▄─▄─█▄─▄▄─█▄─▄███
██▄▀▄███─▀─███─██─██─███─█▄█─███─███▀▄█▀█─██─██─▄─▀██─▄─▄██─▄█▀███─████─▀─████─████─▄█▀██─██▀█
▀▀▀▄▀▀▀▄▄▀▄▄▀▄▄▄▄▀▀▄▄▄▀▄▄▄▀▄▄▄▀▄▄▄▀▄▄▄▄▄▀▄▄▄▄▀▄▄▄▄▀▀▄▄▀▄▄▀▄▄▄▄▄▀▀▄▄▄▀▀▄▄▀▄▄▀▀▄▄▄▀▀▄▄▄▄▄▀▄▄▄▄▄▀
                                    ░░░░░▄▄▀▀▀▀▀▀▀▀▀▄▄░░░
                                    ░░░░█░░░░░░░░░░░░░█░░
                                    ░░░█░░░░░░░░░░▄▄▄░░█░
                                    ░░░█░░▄▄▄░░▄░░███░░█░
                                    ░░░▄█░▄░░░▀▀▀░░░▄░█▄░
                                    ░░░█░░▀█▀█▀█▀█▀█▀░░█░
                                    ░░░▄██▄▄▀▀▀▀▀▀▀▄▄██▄░

                                    Версия программы v1.4
                                    
Разработана, для компании Умный склад в 2020 году, под операционную систему Debian 10 - Buster

Перед началом, необходимо:
1) Сделать IP статику
2) Поставить права на home 

Если это сделал, то вводи имя пользователя!
"
#добавление пользователя
echo -n "Введите имя пользователя (маленькими буквами):"
read usrname
useradd -m -d /home/$usrname -s /bin/bash $usrname
passwd $usrname

#добавляем репозитори
sudo add-apt-repository --remove 'deb cdrom:[Official Debian GNU/Linux Live 10.6.0 kde 2020-09-26T11:03]/ buster main'
echo 'deb http://deb.debian.org/debian/ buster-updates main contrib non-free' |sudo tee -a /etc/apt/sources.list
echo 'deb-src http://deb.debian.org/debian/ buster-updates main contrib non-free' |sudo tee -a /etc/apt/sources.list
echo 'deb http://deb.debian.org/debian/ buster main contrib non-free' |sudo tee -a /etc/apt/sources.list
echo 'deb-src http://deb.debian.org/debian/ buster main contrib non-free' |sudo tee -a /etc/apt/sources.list
echo 'deb http://security.debian.org/debian-security buster/updates main contrib non-free' |sudo tee -a /etc/apt/sources.list
echo 'deb-src http://security.debian.org/debian-security buster/updates main contrib non-free' |sudo tee -a /etc/apt/sources.list
echo 'deb http://deb.debian.org/debian/ stretch main' |sudo tee -a /etc/apt/sources.list.d/1c.list
echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' |sudo tee -a /etc/apt/sources.list.d/google-chrome.list
#добавляем в отдельную папку - google репозитории и устанавливаем
sudo apt update
sudo apt-get install wget -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt update
#вписываем в hosts ip адресс нашего сервака с 1с
echo '192.168.1.234   serveriq-pc' |sudo tee -a /etc/hosts
#устанавливаем программы
sudo apt install libwebkitgtk-3.0-0 libodbc1 ttf-mscorefonts-installer -y
sudo apt install libgsf-1-114 -y
sudo apt-get install aptitude -y
sudo apt install cups -y
sudo apt-get install google-chrome-stable -y
sudo apt install ufw -y
#устанавливаем и настраиваем zabbix
wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-1+buster_all.deb
sudo apt install ./zabbix-release_5.0-1+buster_all.deb
sudo apt update
sudo apt install zabbix-agent -y
echo "Server=192.168.1.72
ServerActive=192.168.1.72" | sudo tee -a /etc/zabbix/zabbix_agentd.conf
ufw allow 10050/tcp
systemctl restart zabbix-agent
#устанавливаем доп программы
wget -q -O - https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
echo 'deb [arch=amd64] https://repo.skype.com/deb stable main' |sudo tee -a /etc/apt/sources.list.d/skype-stable.list
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update
sudo apt-get install skypeforlinux -y
sudo apt install anydesk -y
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb -y
sudo apt-get install snapd -y
sudo snap install icq-im
wget https://launchpad.net/~buglloc/+archive/ubuntu/brick-dev/+build/9286372/+files/brick_0.2.10.34-0ubuntu1~xenialppa0_amd64.deb
sudo apt install ./brick_* -y
sudo apt install ./zoiper5_* -y
sudo apt-get install gxneur -y
sudo apt install flameshot
sudo apt install git -y
sudo apt install seahorse
#yandex-disk setup
echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/yandex-disk.list > /dev/null && wget http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG -O- | sudo apt-key add - && sudo apt-get update && sudo apt-get install -y yandex-disk
#устанавливаем SSh server
sudo apt install openssh-server -y
#распаковываем архив и производим установку тонкого клиента 1с
tar xvzf thin.client_8_3_17_1851.deb64.tar.gz
dpkg -i 1c-*.deb

#ставим дополнительные драйвера на wi-fi и блетуз
sudo apt install ./firmware-iwlwifi_20190114-2_all.deb -y

#дополнительные проги - опционально
#opera-----------------------------
#wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
#sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
#sudo apt update
#sudo apt install opera-stable -y
#yandex browser-----------------------------
#wget https://repo.yandex.ru/yandex-browser/deb/pool/main/y/yandex-browser-beta/yandex-browser-beta_20.9.3.189-1_amd64.deb
#sudo apt install ./yandex-* -y
#установка filezilla -------------------
#sudo apt install filezilla -y

#блокируем USB flash
sudo chmod 700 /media

clear
echo "
██████████████████████████████████████████████████████████████████████████████████████████████
█▄─█─▄██▀▄─██▄─▄▄▀█▄─▄█▄─▀█▀─▄█▄─▄█░▄▄░▄█─▄▄─█▄─▄─▀█▄─▄▄▀█▄─▄▄─█─▄─▄─██▀▄─██─▄─▄─█▄─▄▄─█▄─▄███
██▄▀▄███─▀─███─██─██─███─█▄█─███─███▀▄█▀█─██─██─▄─▀██─▄─▄██─▄█▀███─████─▀─████─████─▄█▀██─██▀█
▀▀▀▄▀▀▀▄▄▀▄▄▀▄▄▄▄▀▀▄▄▄▀▄▄▄▀▄▄▄▀▄▄▄▀▄▄▄▄▄▀▄▄▄▄▀▄▄▄▄▀▀▄▄▀▄▄▀▄▄▄▄▄▀▀▄▄▄▀▀▄▄▀▄▄▀▀▄▄▄▀▀▄▄▄▄▄▀▄▄▄▄▄▀
                        ⣿⣿⣿⣷⣷⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                        ⣿⣿⣿⣷⣷⣿⣿⠄⠄⠄⠄⠄⣷⣿⣿⣿⣿⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                        ⣷⣷⣿⣷⣷⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣿⣿⣿⣷⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣷⣿⣿⣿⣿⣿
                        ⣿⣿⣿⣷⣷⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣿⣿⣷⣷⣷⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿
                        ⣿⣿⣿⣷⣷⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣿⣿⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                        ⣿⣿⣿⣷⣿⣿⣿⠄⠄⠄⠄⣷⣷⣿⣿⣿⣿⣷⣷⠄⠄⠄⠄⠄⠄⣷⣿⣿⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                        ⣿⣿⣿⣷⣿⣿⣿⠄⣷⣿⣿⣿⣿⣿⣷⣷⣷⣷⣿⣿⣿⣷⣷⠄⠄⠄⠄⣷⣿⣿⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿
                        ⣿⣿⣷⣷⣿⣿⣷⠄⣷⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣷⣷⠄⠄⠄⠄⣷⣿⣷⠄⣷⣿⣿⣿⣿⣿⣿
                        ⣿⣿⣷⣷⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⣿⠄⣷⣿⣿⣿⣿⣿
                        ⣿⣿⣷⣿⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⣷⣿⣿⣿⣿⣿⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⣷⠄⣷⣿⠄⣷⣿⣿⣿⣿
                        ⣿⣿⣷⣿⣿⣿⠄⠄⠄⠄⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠄⠄⠄⠄⠄⣿⠄⣿⣿⣿⣷⣷⣿⣿⣿
                        ⣿⣷⣷⣿⣿⣿⠄⠄⠄⠄⠄⣷⣿⣿⣿⣷⣷⣷⣷⣷⠄⠄⠄⣷⣿⣿⠄⠄⠄⣷⣿⠄⣿⣷⣿⣿⠄⣷⣿⣿
                        ⣿⣷⣷⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⣷⣿⣿⣿⣿⣿⣷⣷⣷⠄⠄⠄⠄⣿⠄⠄⠄⠄⣿⣿⠄⣿⣿
                        ⣿⣷⣷⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣷⠄⠄⠄⣿⣿⣷⠄⣿
                        ⣿⣷⣷⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⠄⠄⠄⠄⠄⣿⣿⠄⣿
                        ⣿⣷⣷⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣷⣷
                        ⣿⣷⣷⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⣿⣿
                        ⣿⣷⣷⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣷⠄⣷⠄⠄⠄⠄⣿⣿⣿
                        ⣿⣿⠄⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣷⣿⣷⣷⠄⠄⠄⣷⣿⣿⣿
                        ⣿⣿⠄⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣷⣿⣷
                        ⣿⣿⣷⣷⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣷⣷⣷⣿⣿⣿⣿⣿⣿⣿⠄⣷⣿⣿⣷⣿⣿
                        ⣿⣿⣿⣷⣷⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣷⣿⣿⣿⣿⣷⣷⣿⣷⣷⠄⣿⣿⣿⣷⣿⣿
                        ⠄⣿⣿⣿⣷⣿⣿⣷⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⠄⠄⠄⠄⣷⣷⣷⠄⠄⣷⣿⣿⣿⣷⣿⣿
                        ⠄⠄⣷⣿⣿⣷⣿⣷⠄⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣷⣷⠄⠄⠄⣷⣷⠄⣿⣿⣿⣷⣷⣿⣿
                        ⠄⠄⠄⠄⣷⣷⣿⣿⠄⠄⣷⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣷⣷⣷⣷⠄⣷⣿⣿⣿⣷⣿⣷⣷
                        ⠄⠄⠄⠄⠄⠄⣷⣿⣿⠄⠄⣷⣿⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣷⣿⣿⣿
                        ⠄⠄⠄⠄⠄⠄⠄⠄⣿⣷⠄⠄⣷⣿⣿⣿⣿⣷⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⣿⣿⣷⣿⣷⣿⣿
                        ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⣿⣿⣿⣿⣿⠄⣷⣷⠄⠄⠄⠄⠄⠄⠄⣷⣿⣿⣿⣿⣷⣿⣷⣷⣿
                        ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⣿⣿⣿⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿
                        ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⣿⣿⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                        ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣷⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣷⣿⣿⣿
                        ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⠄⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣷⣿⣿⣿⣿
                        ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⠄⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣷⣷⣿⣿⣿⣿⣿
                        ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣷⣿⣿⣿⣿⣿⣿
                        ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

                                    Версия программы v1.4 
                        Разработал - Мальцев Вадим Евгеньевич в 2020 году
                                    
                                   Telegram @izobretatel9
                                    
                               Настройка ОС выполнена успешно! 

Теперь, необходимо настроить приложения:

1) Раскладка языка
2) Сделать по умолчанию принтер
3) Настроить информационные базы в 1с
4) Настроить учетки в Google Chrome и Brick
5) Сделать кнопку Prt Scr по дефолту для программы Flameshot
"
read -p "Нажмите ENTER для перезагрузки"
#делаем перезагрузку ОС
sudo reboot

#Дополнительне команды
#sudo chmod 755 /media - разрешить монтирование USB
#sudo hostnamectl set-hostname ИМЯ - изменить имя компьютера
#apt full-upgrade -y - обновление системы
