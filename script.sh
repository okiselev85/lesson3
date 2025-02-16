#Зануляем
mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}

#Создаем RAID5
mdadm --create --verbose /dev/md0 -l 5 -n 5 /dev/sd{b,c,d,e,f}

#Прверяем сборку
cat /proc/mdstat

#Проверяем2
mdadm -D /dev/md0

#Создаем раздел GPT c партициями
parted -s /dev/md0 mklabel gpt
parted /dev/md0 mkpart primary ext4 20% 40%
parted /dev/md0 mkpart primary ext4 40% 60%
parted /dev/md0 mkpart primary ext4 60% 80%
parted /dev/md0 mkpart primary ext4 80% 100%

#создание файловой системы
for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md0p$i; done

#монтирование по каталогам
mkdir -p /raid/part{1,2,3,4,5}
for i in $(seq 1 5); do mount /dev/md0p$i /raid/part$i; done
