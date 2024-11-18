log_file=/tmp/expense.log
colour="\e[36m"
echo -e "${colour} disable mysql \e[0m"
dnf module disable mysql -y &>>log_file 
if [ $? = 0 ]; then
   echo "\e[36m success \e[0m"
else
  echo -e "\e[32m failure \e[0m"
fi  
echo -e "${colour} copying the repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file 
if [ $? = 0 ]; then
   echo "\e[36m success \e[0m"
else
  echo -e "\e[32m failure \e[0m"
fi  
echo -e "${colour} Installing the mysql server \e[0m"
dnf install mysql-community-server -y &>>log_file 
if [ $? = 0 ]; then
   echo "\e[36m success \e[0m"
else
  echo -e "\e[32m failure \e[0m"
fi  
echo -e "${colour} start the mysql \e[0m"
systemctl enable mysqld &>>log_file 
systemctl start mysqld &>>log_file   
if [ $? = 0 ]; then
   echo "\e[36m success \e[0m"
else
  echo -e "\e[32m failure \e[0m"
fi  
echo -e "${colour} set the password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file 
if [ $? = 0 ]; then
   echo "\e[36m success \e[0m"
else
  echo -e "\e[32m failure \e[0m"
fi  
