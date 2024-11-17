echo -e "\e[32 Installing the Nginx \e[0m"
dnf install nginx -y 
echo -e "\e[32 copying the expense.conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf
echo -e "\e[32 removing the data \e[0m"
rm -rf /usr/share/nginx/html/* 
echo -e "\e[32 downloading the application \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip 
echo -e "\e[32 extracting the application \e[0m"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
echo -e "\e[32 Starting the nginx \e[0m"
systemctl enable nginx
systemctl restart nginx
