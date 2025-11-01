#!/usr/bin/env bats

# path to your hook (adjust if you keep hook in repo and copy to .git/hooks in CI)
HOOK="./.git/hooks/commit-msg"

setup() {
  # убедимся, что хук исполняемый
  chmod +x "$HOOK"
}

@test "Валидное сообщение коммита «fix: [OSG-123] fix bug with authorization»" {
  msg="fix: [OSG-123] fix bug with authorization"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «fix: [OSG-0] сделал часть задачи 'OSG-0', в которой реализовал метод 'Method_A'»" {
  msg="fix: [OSG-0] сделал часть задачи 'OSG-0', в которой реализовал метод 'Method_A'"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «fix: [OSG-999999] Реализовал фичу, с помощью которой можно пользоваться сервисом целых 999999 секунд!»" {
  msg="fix: [OSG-999999] Реализовал фичу, с помощью которой можно пользоваться сервисом целых 999999 секунд!"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «refactor: [OSG-1245] отрефакторил файл 'README.md', исправив в нем орфографические ошибки»" {
  msg="refactor: [OSG-1245] отрефакторил файл 'README.md', исправив в нем орфографические ошибки"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «test: [OSG-101010] написал testValidateUserData, который проверяет данные пользователя на null»" {
  msg="test: [OSG-101010] написал testValidateUserData, который проверяет данные пользователя на null"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «fix: [OSG-1] написал testValifateUserData, который проверяет данные пользователя на null»" {
  msg="test: [OSG-1] написал testValifateUserData, который проверяет данные пользователя на null"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «fix: [OSG-00123] ИЗМЕНИЛ РАСШИРЕНИЕ У ФАЙЛА НАСТРОЕК 'APPLICATION' С 'PROPERTIES' на 'YAML'»" {
  msg="fix: [OSG-00123] ИЗМЕНИЛ РАСШИРЕНИЕ У ФАЙЛА НАСТРОЕК 'APPLICATION' С 'PROPERTIES' на 'YAML'"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «fix: [OSG-001] CHANGED NAMES IN METHOD 'aaaBbbCcc' TO IMPROVE READABILITY»" {
  msg="fix: [OSG-001] CHANGED NAMES IN METHOD 'aaaBbbCcc' TO IMPROVE READABILITY"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «fix: [OSG-991] Добавил Логику В Метод 'readUserName', Чтобы Можно Было Задавать, Например, Такое Имя: '12@Fa3#I#$(*#21&*+_)}>?\}.'»" {
  msg="fix: [OSG-991] Добавил Функционал В Метод 'readUserName', чтобы можно было задавать, например, такое имя: '12@Fa3#I#$(*#21&*+_)}>?\}.'"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «fix: [OSG-8234] теперь метод 'qwe@!#123' может обрабатывать вот такую строку: '////\\\\////asd\\\/a\s/d\f/g\'»" {
  msg="fix: [OSG-8234] теперь метод 'qwe@!#123' может обрабатывать вот такую строку: '////\\\\////asd\\\/a\s/d\f/g\'"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Валидное сообщение коммита «test: [OSG-59] внедрил  новые   компоненты    в     класс     'SankiSanta' »" {
  msg="test: [OSG-59] внедрил  новые   компоненты    в     класс     'SankiSanta' "
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "Плохое сообщение коммита «fixx: [OSG-00100] тут ошибка в название префикса 'fix'»" {
  msg="fixx: [OSG-00100] тут ошибка в название префикса 'fix'"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут ошибка в название префикса 'fix'"* ]]
}

@test "Плохое сообщение коммита «refaktor: [OSG-000] тут ошибка в название префикса 'refactor'»" {
  msg="refaktor: [OSG-000] тут ошибка в название префикса 'refactor'"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут ошибка в название префикса 'refactor'"* ]]
}

@test "Плохое сообщение коммита «tect: [OSG-010] тут ошибка в название префикса 'test'»" {
  msg="tect: [OSG-010] тут ошибка в название префикса 'test'"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут ошибка в название префикса 'test'"* ]]
}

@test "Плохое сообщение коммита «tеst: [OSG-011] тут русская буква 'е' вместо английской»" {
  msg="tеst: [OSG-011] тут русская буква 'е' вместо английской"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут русская буква 'е' вместо английской"* ]]
}

@test "Плохое сообщение коммита « test: [OSG-0110] тут ненужный пробел перед префиксом»" {
  msg=" test: [OSG-0110] тут ненужный пробел перед префиксом"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут ненужный пробел перед префиксом"* ]]
}

@test "Плохое сообщение коммита «test : [OSG-12345] тут ненужный пробел после префикса»" {
  msg="test : [OSG-12345] тут ненужный пробел после префикса"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут ненужный пробел после префикса"* ]]
}


@test "Плохое сообщение коммита «test:  [OSG-555] тут два пробела перед задачей»" {
  msg="test:  [OSG-555] тут два пробела перед задачей"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут два пробела перед задачей"* ]]
}

@test "Плохое сообщение коммита «test:       [OSG-555] тут семь пробелов перед задачей»" {
  msg="test:       [OSG-555] тут семь пробелов перед задачей"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут семь пробелов перед задачей"* ]]
}

@test "Плохое сообщение коммита « fix : [OSG-292] тут ненужные пробелы до и после префикса»" {
  msg=" fix : [OSG-292] тут ненужные пробелы до и после префикса"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут ненужные пробелы до и после префикса"* ]]
}

@test "Плохое сообщение коммита «: [OSG-1999] тут отсутствует префикс, но есть двоеточие в начале»" {
  msg=": [OSG-1999] тут отсутствует префикс, но есть двоеточие в начале"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут отсутствует префикс, но есть двоеточие в начале"* ]]
}

@test "Плохое сообщение коммита «[OSG-9991] тут сообщение сразу начинается с задачи»" {
  msg="[OSG-9991] тут сообщение сразу начинается с задачи"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут сообщение сразу начинается с задачи"* ]]
}

@test "Плохое сообщение коммита «fix [OSG-90009] тут нет двоеточия после префикса»" {
  msg="fix [OSG-90009] тут нет двоеточия после префикса"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут нет двоеточия после префикса"* ]]
}

@test "Плохое сообщение коммита «fix: (OSG-78) тут задача обернута в круглые скобки а не в квадратные»" {
  msg="fix: (OSG-78) тут задача обернута в круглые скобки а не в квадратные"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут задача обернута в круглые скобки а не в квадратные"* ]]
}

@test "Плохое сообщение коммита «fix: (OSG-1134] тут первая скобка не квадратная, а круглая»" {
  msg="fix: (OSG-1134] тут первая скобка не квадратная, а круглая"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут первая скобка не квадратная, а круглая"* ]]
}

@test "Плохое сообщение коммита «fix: [OSG-3411) тут вторая скобка не квадратная, а круглая»" {
  msg="fix: (OSG-3411] тут первая скобка не квадратная, а круглая"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут первая скобка не квадратная, а круглая"* ]]
}

@test "Плохое сообщение коммита «fix: <OSG-3411} тут обе скобки не квадратные, а круглая и фигурная»" {
  msg="fix: <OSG-3411} тут обе скобки не квадратные, а круглая и фигурная"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут обе скобки не квадратные, а круглая и фигурная"* ]]
}

@test "Плохое сообщение коммита «refactor: [OSG-4545]»" {
  msg="refactor: [OSG-4545]"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут нет пояснительного текста"* ]]
}

@test "Плохое сообщение коммита «refactor: [OSG-6767] »" {
  msg="refactor: [OSG-6767] "
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут вместо пояснительного текста - один пробел"* ]]
}

@test "Плохое сообщение коммита «refactor: [OSG-67678]  »" {
  msg="refactor: [OSG-67678]  "
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут вместо пояснительного текста - два пробела"* ]]
}

@test "Плохое сообщение коммита «refactor: [OSG-111222]         »" {
  msg="refactor: [OSG-111222]         "
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут вместо пояснительного текста - несколько пробелов пробел"* ]]
}

@test "Плохое сообщение коммита «refactor: тут нет задачи»" {
  msg="refactor: тут нет задачи"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут нет задачи"* ]]
}

@test "Плохое сообщение коммита «»" {
  msg=""
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут пустое сообщение коммита"* ]]
}

@test "Плохое сообщение коммита « »" {
  msg=" "
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут сообщение коммита из одного пробела"* ]]
}

@test "Плохое сообщение коммита «  »" {
  msg="  "
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут сообщение коммита из двух пробелов"* ]]
}

@test "Плохое сообщение коммита «      »" {
  msg="      "
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: тут сообщение коммита из нескольких пробелов"* ]]
}
