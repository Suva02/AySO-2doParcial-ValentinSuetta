VERIFICAR SI ESTA INSTALADO LVM
-------------------------------

	apt list --installed | grep lvm


INSTALAR LVM SI NO ESTA INSTALADO
----------------------------------
	
	sudo apt install lvm2


CREAR PARTICIONES PARA IMPLEMENTAR LVM:
---------------------------------------------
(X3)
sudo fdisk /dev/sdc
n new
p (primary)
enter
enter
+1G

(x1)
n new
e (extendida)
enter
enter
+3G

(x2) -> Logicas
n new
enter
+1G


ASIGNAR PARTICION 1 COMO SWAP:
------------------------------
sudo fdisk /dev/sdc

t cambiar el sistema de archivos 
1 (elegimos partición 1)
L (listado de fs)
82 (para asignar el sistema de archivos SWAP)
w (guardar) 


DESTINAR PARTICION 1 COMO SWAP:
-------------------------------
sudo mkswap /dev/sdc1 (Me dio error asi que tuve que reiniciar la VM)


HABILITAR LA MEMORIA SWAP:
--------------------------
sudo swapon /dev/sdc1 (Verificado con -> free -h | cat /proc/swaps | swapon -s)


CAMBIAR LAS PARTICIONES AL SISTEMA DE ARCHIVOS LVM (ESTO HAY QUE HACERLO CON TODAS LAS PARTICIONES DEL DISCO MENOS LA EXTENDIDA, PORQUE SE TIENEN QUE CREAR LAS LOGICAS Y ME DABA ERROR):
---------------------------------------------------
sudo fdisk /dev/sdc
t -> para seleccionar la particion que queremos cambiar
l -> para ver los sistemas de archivo (8E es LVM)
p -> para ver la info de las particioens y ver el sistema de archivos modificado en la ultima columna
w -> guardar




- CREAR VOLUMENES FISICOS: sudo pvcreate /dev/sdc2 /dev/sdc3 /dev/sdc5 /dev/sdc6 (sudo pvs -> para verlos creados)



- CREAR GRUPOS DE VOLUMENES: sudo vgcreate vgAdmin /dev/sdc2 /dev/sdc3
			     sudo vgcreate vgDevelopers /dev/sdc5 /dev/sdc6 ->  (sudo vgs -> para verlos creados)


- CREAR VOLUMENES LOGICOS: 
			sudo lvcreate -L 2G -n lvAdmin vgAdmin
		 	sudo lvcreate -L 1G -n lvDevelopers vgDevelopers
			sudo lvcreate -L 1G -n lvTesters vgDevelopers
			sudo lvcreate -L 1G -n lvDevops vgDevelopers (sudo lvs -> para verlos creados)


MONTAR LOS VOLUMENES LOGICOS:
-----------------------------

(/dev/mapper -> es donde se guardan los volumenes logicos)
 	sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevelopers
 	sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvTesters
 	sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevops
 	sudo mkfs.ext4 /dev/mapper/vgAdmin-lvAdmin

 	sudo mkdir /mnt/lvDevelopers
 	sudo mkdir /mnt/lvTesters
 	sudo mkdir /mnt/lvDevops
 	sudo mkdir /mnt/lvAdmin
 
 	sudo mount /dev/mapper/vgDevelopers-lvDevelopers /mnt/lvDevelopers
 	sudo mount /dev/mapper/vgDevelopers-lvTesters /mnt/lvTesters
 	sudo mount /dev/mapper/vgDevelopers-lvDevops /mnt/lvDevops
 	sudo mount /dev/mapper/vgAdmin-lvAdmin /mnt/lvAdmin

	(Verificar montajes)
 	df -h 
	lsblk -f

