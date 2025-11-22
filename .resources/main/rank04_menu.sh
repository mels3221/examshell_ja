#!/bin/bash
source colors.sh

clear
printf "${CYAN}%s${RESET}\n" "╔═══════════════════════════════════════════════════════════╗"
printf "${BLUE}%s${GREEN}%s${BLUE}%s${RESET}\n" "║" "            📄 試験 RANK 04 - モード選択            " "║"
printf "${CYAN}%s${RESET}\n" "╚═══════════════════════════════════════════════════════════╝"
printf "${YELLOW}${BOLD}%s${RESET}\n" "1. レベルモード"
printf "${YELLOW}${BOLD}%s${RESET}\n" "2. 本番試験モード"
printf "${YELLOW}${BOLD}%s${RESET}\n" "3. メインメニューに戻る"
printf "${GREEN}${BOLD}選択してください (1-3): ${RESET}"
read rank04_opt
case $rank04_opt in
    1)
        bash rank04_level.sh
        ;;
    2)
        bash rank04.sh
        ;;
    3)
        bash intro.sh
        ;;
    *)
        echo "無効な選択です。1、2、または3を入力してください。"
        sleep 1
        bash rank04_menu.sh
        ;;
esac