#!/bin/bash

# Функция для удаления промежуточных файлов
cleanup() {
  rm -f sorted_numbers.txt truncated_average.txt
}

# Проверка наличия необходимого количества аргументов
if [ "$#" -lt 5 ]; then
  echo "Error: At least 5 numbers are required."
  exit 1
fi

# Чтение чисел со стандартного ввода
numbers=()
for ((i=1; i<=$#; i++)); do
  numbers+=(${!i})
done

# Сортировка чисел по возрастанию
sorted_numbers=($(printf '%s\n' "${numbers[@]}" | sort -n))

# Удаление первого и последнего числа
unset 'sorted_numbers[0]'
unset 'sorted_numbers[${#sorted_numbers[@]}-1]'
  
# Вычисление среднего арифметического оставшихся элементов
truncated_sum=0
for n in "${sorted_numbers[@]}"; do
  truncated_sum=$((truncated_sum+n))
done
truncated_average=$((truncated_sum/${#sorted_numbers[@]}))

# Вывод усеченного среднего
echo "Truncated Average: $truncated_average"

# Удаление промежуточных файлов
cleanup

exit 0
