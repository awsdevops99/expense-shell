log_file=/tmp/expense.log
colour="\e[36m"
status_check() {
if [ $? -eq 0 ]; then
   echo -e "\e[36m success \e[0m"
else
  echo -e "\e[32m failure \e[0m"
fi 

}