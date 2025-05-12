#!/bin/bash

# 사용자 입력 받기
read -p "GitHub Email: " email
read -p "GitHub Name: " name

# 5. SSH 연결 테스트
echo "Testing SSH connection to GitHub..."
ssh -T git@github.com

# 6. Git 설정
echo "Setting global Git config..."
git config --global user.email "$email"
git config --global user.name "$name"

echo "Done! Your Git configuration is complete."
