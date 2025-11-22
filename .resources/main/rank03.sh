#!/bin/bash
source functions.sh
source colors.sh
clear
bash label.sh
printf "${BLUE}%s${RESET}\n" "┌─────────────────────────────────────────────────────────┐"
printf "${BLUE}%s${GREEN}%s${BLUE}%s${RESET}\n" "│" "  🎯 試験42 Rank 03の練習レベルを選択  🎯  " "│"
printf "${BLUE}%s${RESET}\n" "└─────────────────────────────────────────────────────────┘"
printf "${CYAN}%s${RESET}\n" "∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼"
printf "${YELLOW}${BOLD}%s${RESET}\n" "🔥 1. Level1 - 中級課題"
printf "${YELLOW}${BOLD}%s${RESET}\n" "💎 2. Level2 - 上級問題"
printf "${CYAN}%s${RESET}\n" "∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼"
printf "${GREEN}${BOLD}選択してください (1-2): ${RESET}"
read opt

case $opt in
    menu)
        bash menu.sh
        ;;
    1)
        clear
        echo "$(tput setaf 2)$(tput bold)level1を準備中...$(tput sgr0)"
        display_animation
        clear
        bash level_base.sh rank03 level1
        ;;
    2)
        mkdir ../../rendu
        clear
        echo "$(tput setaf 2)$(tput bold)level2を準備中...$(tput sgr0)"
        display_animation
        clear
        bash level_base.sh rank03 level2
        ;;
    exit)
        cd ../../../../
        rm -rf rendu
        clear
        exit
        ;;
    *)
        echo "$(tput setaf 1)入力が間違っています$(tput sgr0)"
        sleep 1
        bash rank03.sh
esac
