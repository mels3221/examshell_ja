#!/bin/bash
source colors.sh

rank=$1
level=$2

# Save base directory (where script was launched from)
base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Centralized temp file to track subject
subject_file="/tmp/.current_subject_${rank}_${level}"

# Define subject pool using case statement instead of associative array
get_subjects() {
    case "$level" in
        level1)
            echo "broken_gnl filter scanf"
            ;;
        level2)
            echo "n_queens permutations powerset rip tsp"
            ;;
        *)
            echo ""
            ;;
    esac
}

pick_new_subject() {
    subjects_list=$(get_subjects)
    IFS=' ' read -r -a qsub <<< "$subjects_list"
    count=${#qsub[@]}
    random_index=$(( RANDOM % count ))
    chosen="${qsub[$random_index]}"
    echo "$chosen" > "$subject_file"
}

prepare_subject() {
    mkdir -p "$base_dir/../../rendu/$chosen"
    
    # Create appropriate files based on subject requirements
    case $chosen in
        "broken_gnl")
            touch "$base_dir/../../rendu/$chosen/get_next_line.c"
            touch "$base_dir/../../rendu/$chosen/get_next_line.h"
            ;;
        "filter")
            touch "$base_dir/../../rendu/$chosen/filter.c"
            ;;
        "scanf")
            touch "$base_dir/../../rendu/$chosen/ft_scanf.c"
            ;;
        *)
            # For other subjects, create generic .c file
            touch "$base_dir/../../rendu/$chosen/$chosen.c"
            ;;
    esac

    cd "$base_dir/../$rank/$level/$chosen" || {
        echo -e "${RED}課題フォルダが見つかりません。${RESET}"
        exit 1
    }

    clear
    echo -e "${CYAN}${BOLD}あなたの課題: $chosen${RESET}"
    echo "=================================================="
    cat sub.txt
    echo
    echo -e "=================================================="
    echo -e "${YELLOW}'test'でコードをテスト、'next'で新しい問題を取得、'exit'で終了します。${RESET}"
}

# Initial subject selection
if [ -f "$subject_file" ]; then
    chosen=$(cat "$subject_file")
    echo -e "${BLUE}🔁 前回選択した課題を再開します: $chosen${RESET}"
else
    pick_new_subject
    chosen=$(cat "$subject_file")
    echo -e "${GREEN}🎯 New subject chosen: $chosen${RESET}"
fi

prepare_subject

# Interactive loop
while true; do
    echo -e "${MAGENTA}${BOLD}Enter command: ${RESET}"
    read command

    case $command in
        test)
            if [ -f "tester.sh" ]; then
                echo -e "${BLUE}テスターを実行中...${RESET}"
                bash tester.sh
                echo -e "${CYAN}Test completed. Continue working or type 'next' for a new subject.${RESET}"
            else
                echo -e "${YELLOW}No tester available for this subject. Please test manually.${RESET}"
            fi
            ;;
        next)
            pick_new_subject
            chosen=$(cat "$subject_file")
            echo -e "${GREEN}🎯 New subject chosen: $chosen${RESET}"
            prepare_subject
            ;;
        exit)
            echo -e "${RED}試験モードを終了します...${RESET}"
            rm -f "$subject_file"
            cd "$base_dir"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown command. Use 'test', 'next', or 'exit'.${RESET}"
            ;;
    esac
done