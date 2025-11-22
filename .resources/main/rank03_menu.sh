#!/bin/bash
source colors.sh

clear
printf "${CYAN}%s${RESET}\n" "╔═══════════════════════════════════════════════════════════╗"
printf "${BLUE}%s${GREEN}%s${BLUE}%s${RESET}\n" "║" "            📄 試験 RANK 03 - モード選択            " "║"
printf "${CYAN}%s${RESET}\n" "╚═══════════════════════════════════════════════════════════╝"
printf "${YELLOW}${BOLD}%s${RESET}\n" "1. レベルモード"
printf "${YELLOW}${BOLD}%s${RESET}\n" "2. 本番試験モード"
printf "${YELLOW}${BOLD}%s${RESET}\n" "3. メインメニューに戻る"
printf "${GREEN}${BOLD}選択してください (1-3): ${RESET}"
read rank03_opt
case $rank03_opt in
    1)
        bash rank03.sh
        ;;
    2)
        bash rank03_real_mode.sh
        ;;
    3)
        bash intro.sh
        ;;
    *)
        echo "無効な選択です。1、2、または3を入力してください。"
        sleep 1
        bash rank03_menu.sh
        ;;
esac