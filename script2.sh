#ломаем одно из блочных устройств
mdadm /dev/md0 --fail /dev/sdd

#выводим статус рэйд и смотрим какой диск выпал
cat /proc/mdstat
mdadm -D /dev/md0

#Удаляем на горячую диск
mdadm /dev/md0 --remove /dev/sdd

#Вставляекм на горячую новый диск
mdadm /dev/md0 --add /dev/sdd

#смотрим на процесс ребилда рэйда
cat /proc/mdstat
mdadm -D /dev/md0
