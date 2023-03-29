for file in *.BIN
do
mavlogdump.py "$file" --planner --format mat --mat_file "${file%.BIN}.mat" 
done
