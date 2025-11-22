clear
bash label.sh
echo "$(tput setaf 2)$(tput bold)コマンド一覧$(tput sgr0)"
echo =============================
echo "$(tput setaf 4)'exit'$(tput sgr 0) と入力すると試験練習を終了します。"
echo "$(tput setaf 4)'next'$(tput sgr 0) と入力すると次の課題に進みます。"
echo "$(tput setaf 4)'test'$(tput sgr 0) と入力するとコードをテストします。"
echo "$(tput setaf 4)'menu'$(tput sgr 0) と入力するとメニューに戻ります。"
echo =============================
read -rp "Enterキーを押してメニューに戻る: " opt
bash menu.sh

