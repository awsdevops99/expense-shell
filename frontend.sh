echo -e "\e[32m Installing the Nginx \e[0m"
dnf install nginx -y &>> /tmp/expense.log

echo -e "\e[32m copying the expense.conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>> /tmp/expense.log
echo -e "\e[32m removing the data \e[0m"
rm -rf /usr/share/nginx/html/* &>> /tmp/expense.log
echo -e "\e[32m downloading the application \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>> /tmp/expense.log
echo -e "\e[32m extracting the application \e[0m"
cd /usr/share/nginx/html &>> /tmp/expense.log
unzip /tmp/frontend.zip &>> /tmp/expense.log
echo -e "\e[32m Starting the nginx \e[0m"
systemctl enable nginx &>> /tmp/expense.log
systemctl restart nginx &>> /tmp/expense.log
