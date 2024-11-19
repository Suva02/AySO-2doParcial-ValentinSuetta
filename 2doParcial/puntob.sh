INSTALACION ANSIBLE
-------------------
sudo apt update
sudo apt install ansible
yes
(restart kernel si lo pide)


COMPROBAR INSTALACION
---------------------
sudo apt list --installed | grep ansible 
ansible --version


INSTRUCCIONES Y ACCIONES REALIZADAS
-----------------------------------

	# Levantar una maquina virtual (1_equipo) -> cambio de nombre y la IP (Ansible Management Node - 192.168.56.8)
	# Levantar una maquina virtual (1_equipo-con2discos) -> cambio de nombre y la IP (Desarrollo - 192.168.56.9)

	ip address show -> Para verificar dentro de las VMS, si la ip es la correcta

	

	Ansible Management Node -> ssh-keygen -> enter -> enter -> se crea clave publica y privada (Se crean dos archivos: id_rsa y id_rsa.pub)
	Ansible Management Node -> cat .ssh/id_rsa.pub (Para consultar la clave publica)
	Desarrollo -> vim .ssh/authorized_keys (pego la clave publica de produccion, aca adentro)
	Ansible Management Node -> ssh vagrant@192.168.56.9 (donde dice ip ponemos la ip de la vm de desarrollo y le doy enter + yes para conectar)
	Ansible Management Node -> git clone https://github.com/upszot/UTN-FRA_SO_Ansible.git
	Ansible Management Node -> cd [nombreDelRepo]
	Ansible Management Node -> cd [ejemplo02]
	Ansible Management Node -> vim inventory (Se editó para poner el nombre de la VM Desarrollo y su IP. El resto, se comentó todo.)
	Ansible Management Node -> ansible-playbook -i inventory playbook.yml (Para ejecutar el archivo playbook)
	Desarrollo -> apache2 -v (Para verificar la instalacion de apache en el servidor de desarrollo)	


