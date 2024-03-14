#!/bin/bash

# Функция для вывода инструкции
usage() {
    echo "Please enter numbers one by one, pressing Enter after each. To end input, press Enter on an empty line."
}

# Проверка, что скрипт не запущен с аргументами
if [[ $# -gt 0 ]]; then
    usage
    exit 1
fi

# Считывание чисел в массив
nums=()
while true; do
    read -p "Enter a number (leave empty to finish input): " input

    # Проверяем пустую строку - признак окончания ввода
    if [[ -z "$input" ]]; then
        break
    fi

    # Проверяем, что введено число (целое или с плавающей точкой)
    if [[ ! "$input" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Error: Input must be a number."
        exit 1
    fi

    nums+=("$input")
done

# Проверяем, что чисел достаточно для расчета усеченного среднего
if [[ ${#nums[@]} -lt 5 ]]; then
    echo "Error: At least 5 numbers are required."
    exit 1
fi

# Сортировка чисел по возрастанию
sorted_numbers=($(printf '%s\n' "${nums[@]}" | sort -n))

len=${#nums[@]}

# Вычисление среднего арифметического оставшихся элементов
truncated_sum=0
for ((i=1; i<len - 1; i++)); do
    truncated_sum=$(echo "$truncated_sum+${sorted_numbers[i]}" | bc)
done

((len=len-2))
truncated_average=$(echo "scale=2; $truncated_sum / $len" | bc)

# Вывод усеченного среднего
echo "Truncated Average: $truncated_average"
exit 0
