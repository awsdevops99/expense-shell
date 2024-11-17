echo -e "\e[32m Installing the Nginx \e[0m"
dnf install nginx -y 
echo -e "\e[32m copying the expense.conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf
echo -e "\e[32m removing the data \e[0m"
rm -rf /usr/share/nginx/html/* 
echo -e "\e[32m downloading the application \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip 
echo -e "\e[32m extracting the application \e[0m"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
echo -e "\e[32m Starting the nginx \e[0m"
systemctl enable nginx
systemctl restart nginx
