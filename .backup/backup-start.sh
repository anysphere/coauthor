  cd /home/ubuntu/coauthor
  cd .backup
  ./cron.sh
  mkdir -p /home/ubuntu/dump
  sudo apt install awscli -y
  aws s3 cp s3://coauthor-backup-bucket-s3/0-coauthor-backup-latest /home/ubuntu/dump/coauthor --recursive
  cd /home/ubuntu
