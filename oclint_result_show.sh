#!/bin/bash

function dealOCLintResult () {


	echo '-----分析中-----'

	# 自定义排除警告的目录，将目录字符串加到数组里面
	# 转化为：-e Debug.m -e Port.m -e Test
	exclude_files=("cardloan_js" "Pods" "tensorflow" "APITool_JZB" "ZYBBaseLib")

	exclude=""
	for i in ${exclude_files[@]}; do
		exclude=${exclude}"-e "${i}" "
	done
	echo "排除目录：${exclude}"

  
    nowReportType="-report-type xcode"

	# 生成报表
	oclint-json-compilation-database ${exclude} -- \
	${nowReportType} \
	-rc LONG_LINE=200 \
	-disable-rule ShortVariableName \
	-disable-rule ObjCAssignIvarOutsideAccessors \
	-disable-rule AssignIvarOutsideAccessors \
	-max-priority-1=1000 \
	-max-priority-2=1000 \
	-max-priority-3=1000 
echo '-----分析完毕-----'

}


function showOCLintResult () {

if [ -f ./compile_commands.json ]
then
echo '-----存在编译数据compile_commands.json-----'

		if [ $CONFIGURATION = "Debug" ]
		then
		echo '-----Debug模式下-----'
		dealOCLintResult
		else
		echo "-----非Debug模式下-----"

		fi


else
echo "-----不存在编译数据compile_commands.json-----"
fi

}

showOCLintResult

