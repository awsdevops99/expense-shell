log_file=/tmp/expense.log
colour="\e[36m"
status_check() {
if [ $? -eq 0 ]; then
   echo -e "\e[36m success \e[0m"
else
  echo -e "\e[32m failure \e[0m"
fi 

}
echo -e "${colour} Installing the Nginx \e[0m"
dnf install nginx -y &>>$log_file
status_check 

echo -e "${colour} copying the expense.conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
status_check 
echo -e "${colour} removing the data \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
status_check   
echo -e "${colour} downloading the application \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
status_check 
echo -e "${colour} extracting the application \e[0m"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
status_check 
echo -e "${colour} Starting the nginx \e[0m"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
status_check 
