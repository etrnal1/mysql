du -sh *.dmp | xargs -I {} rm {} 
# 压缩所有的dmp 文件
gzip *.dmp 
find . -name "*.dmp" -exec gzip {} \;
# 解压源文件
gunzip file.gz
#查看原文件
zcat file.gz 
# 文件解压
gunzip file.gz

log() {
    local ts
    ts=$(date "+%Y-%m-%d %H:%M:%S")
    while IFS= read -r line || [ -n "$line" ]; do
        echo "[$ts] $line"
    done <<< "$*"
}

	#IFS= read -r line：逐行读取文本，防止空格/转义被破坏
	#•	<<< "$*"：将参数整体传给 read，即使是多行也可以#分行处理
	#•	|| [ -n "$line" ]：保证最后一行不是空行时也能被打印（处理无换行结尾）
