#!/bin/bash
source colors.sh

rank=$1
level=$2

# Save base directory (where script was launched from)
base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Centralized temp file to track subject
subject_file="/tmp/.current_subject_${rank}_${level}"

# Define subject pool
get_subjects() {
    case "$level" in
        level1)
            echo "bigint polyset vect2"
            ;;
        level2)
            echo "bsq life"
            ;;
        *)
            echo ""
            ;;
    esac
}

# Pick a new random subject
pick_new_subject() {
    subjects_list=$(get_subjects)
    IFS=' ' read -r -a qsub <<< "$subjects_list"
    count=${#qsub[@]}
    random_index=$(( RANDOM % count ))
    chosen="${qsub[$random_index]}"
    echo "$chosen" > "$subject_file"
}

# Prepare the subject folder and files
prepare_subject() {
    mkdir -p "$base_dir/../../rendu/$chosen"

    if [[ "$level" == "level2" ]]; then
        # Level2 → create .c and .h only if missing
        [ ! -f "$base_dir/../../rendu/$chosen/$chosen.c" ] && touch "$base_dir/../../rendu/$chosen/$chosen.c"
        [ ! -f "$base_dir/../../rendu/$chosen/$chosen.h" ] && touch "$base_dir/../../rendu/$chosen/$chosen.h"
    else
        # Level1 → create .cpp and .hpp
        [ ! -f "$base_dir/../../rendu/$chosen/$chosen.cpp" ] && touch "$base_dir/../../rendu/$chosen/$chosen.cpp"

        if [ ! -f "$base_dir/../../rendu/$chosen/$chosen.hpp" ]; then
            if [ -f "$base_dir/../rank05/$level/$chosen/$chosen.hpp" ]; then
                cp "$base_dir/../rank05/$level/$chosen/$chosen.hpp" "$base_dir/../../rendu/$chosen/$chosen.hpp"
            else
                touch "$base_dir/../../rendu/$chosen/$chosen.hpp"
            fi
        fi
    fi

    # Special case: Polyset for rank05 level1
    if [[ "$rank" == "rank05" && "$level" == "level1" && "$chosen" == "polyset" ]]; then
        src_subject_dir="$base_dir/../rank05/level1/polyset/subject"
        dest_dir="$base_dir/../../rendu/polyset/subject"
        if [ -d "$src_subject_dir" ]; then
            mkdir -p "$dest_dir"
            cp -r "$src_subject_dir" "$dest_dir"
        fi
    fi

    # Go to the subject folder dynamically
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
fi

prepare_subject

# Command loop
while true; do
    read -rp "/> " input
    case "$input" in
        test)
            clear
            echo -e "${GREEN}tester.shを実行中...${RESET}"
            output=$(./tester.sh 2>&1)
            echo "$output" | tee tester_output.log

            if echo "$output" | grep -q "PASSED"; then
                echo -e "${GREEN}${BOLD}✔️  合格!${RESET}"
                rm -f "$subject_file"
                sleep 1
                exit 0
            else
                echo -e "${RED}${BOLD}❌  不合格。${RESET}"
                sleep 1
                exit 1
            fi
            ;;
        next)
            echo -e "${BLUE}🔄 新しい課題を選択中...${RESET}"
            pick_new_subject
            chosen=$(cat "$subject_file")
            prepare_subject
            ;;
        exit)
            echo "終了します..."
            exit 0
            ;;
        *)
            echo "'test'でコードをテスト、'next'で次の問題へ、'exit'で終了します。"
            ;;
    esac
done
