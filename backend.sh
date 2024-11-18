source common.sh
if [ -z "$1" ]; then
  echo Password Input Missing
  exit
fi
MYSQL_ROOT_PASSWORD=$1

echo -e "${colour} Disable node js default version \e[0m"
dnf module disable nodejs -y &>>$log_file
status_check
echo -e "${colour} Enable nodejs \e[0m"
dnf module enable nodejs:18 -y &>>$log_file
status_check
echo -e "${colour} Installing the nodejs \e[0m"
dnf install nodejs -y &>>$log_file
status_check
echo -e "${colour} copy backend.service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
status_check 

id expense &>>$log_file
if [ $? -ne 0 ]; then
   echo -e "${colour} add application user /e[0m"
   useradd expense &>>$log_file    
status_check
fi
if [ ! -d /app ]; then
  echo -e "${color} Create Application Directory \e[0m"
  mkdir /app &>>$log_file
  status_check
fi
echo -e "${colour} download application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file 
status_check
dnf install unzip -y &>>"$log_file"
status_check
echo -e "${colour} extract the application content \e[0m"
cd /app &>>$log_file
unzip /tmp/backend.zip  
status_check
echo -e "${colour} installing the npm \e[0m" 
npm install &>>$log_file
status_check
echo -e "${colour} installing the client software \e[0m" 
dnf install mysql -y &>>$log_file
status_check 
echo -e "${color} Load Schema \e[0m"
mysql -h 172.31.46.50 -uroot -p${MYSQL_ROOT_PASSWORD} < /app/schema/backend.sql &>>$log_file
status_check
echo -e "${colour} starting the backend services \e[0m" 
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
status_check