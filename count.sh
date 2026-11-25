
#!/bin/bash

ROOT="${1:-.}"

total=0
files=0

printf "%-60s %10s\n" "FILE" "WORD COUNT"
printf "%-60s %10s\n" "------------------------------------------------------------" "----------"

while IFS= read -r -d '' file; do
    count=$(wc -w < "$file")
    printf "%-60s %10d\n" "$file" "$count"
    ((total += count))
    ((files++))
done < <(find "$ROOT" -type f -name '*.typ' -print0)

printf "%-60s %10s\n" "------------------------------------------------------------" "----------"
printf "%-60s %10d\n" "TOTAL ($files files)" "$total"
