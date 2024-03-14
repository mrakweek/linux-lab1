#!/bin/bash

# Функция для вывода инструкции
usage() {
    echo "Please enter integers one by one, pressing Enter after each. To end input, press Enter on an empty line."
}


# Проверка, что скрипт не запущен с аргументами
if [[ $# -gt 0 ]]; then
    usage
    exit 1
fi

# Считывание чисел в массив
nums=()
while IFS= read -r line; do
    # Проверяем пустую строку - признак окончания ввода
    if [[ -z "$line" ]]; then
        break
    fi
    
    # Проверяем, что введено целое число
    if ! [[ "$line" =~ ^-?[0-9]+$ ]]; then
        echo "Error: Input must be an integer."
        exit 1
    fi
    nums+=("$line")
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
	truncated_sum=$((truncated_sum+${sorted_numbers[i]}))
done

((len=len-2))
let "truncated_average=$truncated_sum/$len"

# Вывод усеченного среднего
echo "Truncated Average: $truncated_average"
exit 0

