#!/usr/bin/env bats

# path to your hook (adjust if you keep hook in repo and copy to .git/hooks in CI)
HOOK="./.git/hooks/commit-msg"

setup() {
  # убедимся, что хук исполняемый
  chmod +x "$HOOK"
}

@test "valid message passes" {
  msg="fix: [OSG-123] исправлен баг с авторизацией"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}

@test "missing type fails" {
  msg="[OSG-123] исправлен баг"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: сообщение коммита должно начинаться"* ]]
}

@test "missing JIRA fails" {
  msg="fix: исправлен баг"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"Ошибка: после типа коммита должна идти ссылка на задачу"* ]]
}

@test "empty message body after jira fails" {
  msg="test: [OSG-12] "
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"слишком общое"* ]] || [[ "${output}" == *"Ошибка:"* ]]
}

@test "bad generic body fails (fix bug)" {
  msg="fix: [OSG-99] fix bug"
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -ne 0 ]
  [[ "${output}" == *"слишком общое/неинформативное"* ]] || [[ "${output}" == *"Ошибка:"* ]]
}

# Дополнительно: пробелы, многострочное сообщение
@test "multiline commit message with valid first line passes" {
  msg=$'docs: [OSG-10] обновлена документация\n\nПодробности изменений...'
  tmp=$(mktemp)
  echo "$msg" > "$tmp"

  run "$HOOK" "$tmp"
  [ "$status" -eq 0 ]
}
