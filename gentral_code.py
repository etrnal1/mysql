from datetime import date, timedelta

# 输出文件名
output_file = "insert_code_100k.sql"

# 每批插入的记录数
batch_size = 1000
total_rows = 100000
values = []

sql_lines = ["START TRANSACTION;\n"]

def get_created_at(index):
    if index < 30000:
        base = date(2024, 1, 1)
        day_offset = index % 31
    elif index < 60000:
        base = date(2024, 2, 1)
        day_offset = index % 29
    else:
        base = date(2024, 3, 1)
        day_offset = index % 31
    return (base + timedelta(days=day_offset)).isoformat()

for i in range(1, total_rows + 1):
    code = f"CODE{i:06d}"
    name = f"Name {i}"
    status = i % 5
    created_at = get_created_at(i - 1)
    values.append(f"('{code}', '{name}', {status}, '{created_at}')")

    if i % batch_size == 0:
        insert_stmt = "INSERT INTO `code` (`code`, `name`, `status`, `created_at`) VALUES\n"
        insert_stmt += ",\n".join(values) + ";\n"
        sql_lines.append(insert_stmt)
        values = []

sql_lines.append("COMMIT;\n")

with open(output_file, "w", encoding="utf-8") as f:
    f.writelines(sql_lines)

print(f"✅ SQL 文件已生成：{output_file}")