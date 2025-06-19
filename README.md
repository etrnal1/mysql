# mysql
mysql的一些基础知识

# 导出区段数据
mysqldump ... --where="created_at >= '2024-01-01' AND created_at < '2024-02-01'" fcs code

	IFS= read -r line：逐行读取文本，防止空格/转义被破坏
	•	<<< "$*"：将参数整体传给 read，即使是多行也可以分行处理
	•	|| [ -n "$line" ]：保证最后一行不是空行时也能被打印（处理无换行结尾）

# 加载数据
    #!/bin/bash

DB="mydb"
TABLE="mytable"
FILE="data.txt"

mysql -u root -p --local-infile=1 -e "
LOAD DATA LOCAL INFILE '$FILE'
INTO TABLE $DB.$TABLE
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n';
"

	•	--local-infile=1：启用客户端允许加载本地文件
	•	INTO TABLE mydb.mytable：导入目标表
	•	FIELDS TERMINATED BY '\t'：列用 tab 分隔（这是 mysql -e 默认格式）
	•	LINES TERMINATED BY '\n'：每行一条记录
