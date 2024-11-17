log_file=/tmp/expense.log
colour="\e[36m"
echo -e "${colour} Installing the Nginx \e[0m"
dnf install nginx -y &>>$log_file
echo $?

echo -e "${colour} copying the expense.conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?
echo -e "${colour} removing the data \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?
echo -e "${colour} downloading the application \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
echo $?
echo -e "${colour} extracting the application \e[0m"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
echo $?
echo -e "${colour} Starting the nginx \e[0m"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?
