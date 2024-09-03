awk '/\/drotaca_soberano\/app\/controllers\// {path = gensub(/.*\/drotaca_soberano\/app\/controllers\/([^?]+).*call=([^&]+).*/, "\\1 \\2", "g", $7); sum[path] += $10; n[path]++} END {for (path in sum) {printf "%50s - Total Seg: %7s - Quantity: %5d - Avg: %10s\n", path, sum[path]/1000, n[path], sum[path]/n[path]/1000}}' /var/log/apache2/access.log


# otras versiones o intentos
#awk '/\/drotaca_soberano\/app\/controllers\// { sum[$7] += $10 n[$7]++ } END { for (path in sum) { printf "%5s Total Seg: %5s Quantity: %d Avg: %5s\n", path, sum[path]/1000, n[path], sum[path]/n[path]/1000 } }' /var/log/apache2/access.log | sed -n '$p'
#awk '/\/drotaca_soberano\/app\/controllers\// {path = gensub(/.*\/drotaca_soberano\/app\/controllers\/([^ ]+).*/, "\\1", "g", $7); sum[path] += $10; n[path]++} END {for (path in sum) {printf "%s Total Seg: %5s Quantity: %d Avg: %5s\n", path, sum[path]/1000, n[path], sum[path]/n[path]/1000}}' /var/log/apache2/access.log
#awk '/\/drotaca_soberano\/app\/controllers\// {sub(/&dhxr.*/, "", $7); sum[$7] += $10; n[$7]++} END {for (p in sum) printf "%s Total Seg: %s Quantity: %d Avg: %s\n", p, sum[p]/1000, n[p], sum[p]/n[p]/1000}' /var/log/apache2/access.log
#awk -F '[=&]' '/\/drotaca_soberano\/app\/controllers\// {call = $4; sum[call] += $10; n[call]++} END {for(call in sum) {printf "%s Total Seg: %5s Quantity: %d Avg: %5s\n", call, sum[call]/1000, n[call], sum[call]/n[call]/1000}}' /var/log/apache2/access.log | sed -n '$p'
#awk '/\/drotaca_soberano\/app\/controllers\// {path = gensub(/.*\/drotaca_soberano\/app\/controllers\/([^ ?]+).*/, "\\1", "g", $7); sub(/call=[^&]+&?/, "", path); sum[path] += $10; n[path]++} END {for (path in sum) {printf "%s Total Seg: %5s Quantity: %d Avg: %5s\n", path, sum[path]/1000, n[path], sum[path]/n[path]/1000}}' /var/log/apache2/access.log

