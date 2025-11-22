#!/bin/bash
source functions.sh
source colors.sh
clear
bash label.sh
printf "${BLUE}%s${RESET}\n" "┌─────────────────────────────────────────────────────────┐"
printf "${BLUE}%s${GREEN}%s${BLUE}%s${RESET}\n" "│" "  🎯 試験42 Rank 02の練習レベルを選択  🎯  " "│"
printf "${BLUE}%s${RESET}\n" "└─────────────────────────────────────────────────────────┘"
printf "${CYAN}%s${RESET}\n" "∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼"
printf "${YELLOW}${BOLD}%s${RESET}\n" "⭐ 1. Level0 - 基礎練習"
printf "${YELLOW}${BOLD}%s${RESET}\n" "🔥 2. Level1 - 中級課題"
printf "${YELLOW}${BOLD}%s${RESET}\n" "💎 3. Level2 - 上級問題"
printf "${YELLOW}${BOLD}%s${RESET}\n" "🏆 4. Level3 - エキスパートレベル"
printf "${CYAN}%s${RESET}\n" "∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼∼"
printf "${GREEN}${BOLD}選択してください (1-4): ${RESET}"
read opt

case $opt in
    menu)
        bash menu.sh
        ;;
    1)
        clear
        echo "$(tput setaf 2)$(tput bold)level0を準備中 $(tput sgr0)"
        display_animation
        clear
        bash level_base.sh rank02 level0
        ;;
    2)
        mkdir ../../rendu
        clear
        echo "$(tput setaf 2)$(tput bold)level1を準備中...$(tput sgr0)"
        display_animation
        clear
        bash level_base.sh rank02 level1
        ;;
    3)
        mkdir ../../rendu
        clear
        echo "$(tput setaf 2)$(tput bold)level2を準備中...$(tput sgr0)"
        display_animation
        clear
        bash level_base.sh rank02 level2
        ;;
    4)
        mkdir ../../rendu
        clear
        echo "$(tput setaf 2)$(tput bold)level3を準備中...$(tput sgr0)"
        display_animation
        clear
        bash level_base.sh rank02 level3
        ;;
    exit)
        cd ../../../../
        rm -rf rendu
        clear
        exit 1
        ;;
    *)
        echo "$(tput setaf 1)入力が間違っています$(tput sgr0)"
        sleep 1
        bash rank02.sh
esac
