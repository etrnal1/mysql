#!/bin/bash
#工具函数
log(){

    echo "%s"|printf 
    echo $(date "+%Y-%m-%d %H:%M:%S")
}

#创建数据库
create_table(){
    mysql < create_database.sql
} 
# 创建分区
create_tale_fenqu(){
    mysql <create_table_fenqu.sql

}
# 查询分区
select_table(){
    mysql -t -v < select_table_partition.sql >1.log

}
# 分区里面查询数据 传递参数$table 
export_table(){
    sql="select count(*) from back;"
    table="code"
    mysqldump --default-character-set=utf8mb4 \
  --single-transaction \
  --skip-add-drop-table \
  --skip-add-locks \
  --where="created_at >= '2024-01-01' AND created_at < '2024-02-01'" \
  fcs ${table}
   > code.sql

}
# 测试Partition分区参数
export_table_fenqu(){
    #sql="select count(*) from code;"
    table="code"
    mysqldump --default-character-set=utf8mb4 \
  --single-transaction \
  --skip-add-drop-table \
  --skip-add-locks \
  --where="created_at >= '2024-01-01' AND created_at < '2024-03-31'" \
  fcs ${table}  \
   > code.dmp

}
# 导入10万条数据
genertal_table(){
    mysql -t -v fcs <"insert_code_100k.sql"
}
clean_fenqu_table(){
    table="code"
    mysql -e "ALTER table code TRUNCATE PARTITION p202401,p202402;" \
    fcs  
}
main(){
   
   
    echo "脚本名字: "$(basename $0)
   
    if [[ -z $1 ]];then
        log "不做任何操作"
      

    else
       
        echo "获取参数: "$1

        case $1 in
            "start") 
                echo 1
            ;;
            "export") 
                echo "开始导出数据"
                export_table_fenqu
                echo `date +%Y-%m-%d`"导出数据结束"
            ;;
            "b") echo default
            ;;
            "genertal")
                echo "执行生成语句"
                genertal_table  
            ;;
            "clean")
                echo "清理分区"
                clean_fenqu_table
                echo "清理分区解释"
            ;;
            *)  
                log 
                echo "不做其他操作"

               
            ;;
        esac
    fi
    
   
 
   # echo $?
}
main $1

