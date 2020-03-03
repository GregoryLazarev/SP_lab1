#!/bin/bash
echo -e "\nПрограмма проверки изменений"
echo "Данная программа позволяет проверить, изменялось ли содержимое файла после указанной даты"
echo "Разработчик: Лазарев Григорий"
trig=1

while ( [ "$trig" -ne 0 ] )
do
	echo -e "\nВы находитесь в дирректории $(pwd) \nВведите имя файла"
	read fname
	f=0
	while [ $f -eq 0 ]
	do
		if [ ! -e $fname ]
		then
			echo "Неверно введено имя афйла"
			echo -e "Хотите продолжить? [Y/n]"
			t=0
			while [ $t -eq 0 ]
			do
				read des			
				case "$des" in
					y|Y) t=1
						 echo "Введите имя файла"
						 read fname
						 ;;
					n|N) t=2
						 exec 2>>errfile
		 				 echo "Неверно введено имя афйла" >&2
						 exit 1
						 ;;
					*) echo -e "Хотите продолжить? [Y/n]"
						 ;;
				esac
			done			
		else
			f=1
		fi
	done

	echo "Введите дату в формате гггг-мм-дд"
	read u_date
	fdate=$(date -r $fname +%s)
	udate=$(date -d $u_date +%s)

	if [ $fdate -gt $udate ]
	then
		echo "Содержимое файла изменялось после указанной даты"
		exit 120
	else
		echo "Содержимое файла не изменялось после указанной даты"
	fi
	echo -e "\n1	продолжить\n0	выход"
	
	t=0
	while [ $t -eq 0 ]
	do
		read des			
		case "$des" in
			0) 	t=1
				trig=0
				;;
			1)	t=2
				;;
			*) 	echo -e "\n1	продолжить\n0	выход"
				;;
		esac
	done
	
done
