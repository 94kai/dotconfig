" v模式下执行命令 
" convert a table copy from excel to makedown table format
" convert a column value list to a markdown format row
function! GenerateAMarkdownTableRowFunc(colValueList)
    let resultStr = ''
    let i = 0
    for colValue in a:colValueList
        let resultStr = resultStr . " | " . colValue
        let i = i + 1
    endfor
    let resultStr = resultStr . " |"
    " remove the space at the beginning
    let resultStr = strpart(resultStr, 1, strlen(resultStr) - 1)
    return resultStr
endfunction
" call GenerateAMarkdownTableRowFunc to convert xls table to markdown
function! GenerateMarkdownTable(start,end) 
    " read all lines into a list
    let allLines = getline(a:start,a:end)


	let resultLines = []
    " deal with the table head
    let colValueList = split(allLines[0], '\t', 1)
    call add(resultLines, GenerateAMarkdownTableRowFunc(colValueList))
    " deal with the split line between table body and head
    let colValueList = split(allLines[0], '\t', 1)
    let tmpColSplitLineStr = ''
    let i = 0
    for colValue in colValueList
        let tmpColSplitLineStr = tmpColSplitLineStr . " | " . "---"
        let i = i + 1
    endfor
    let tmpColSplitLineStr = tmpColSplitLineStr . " |"
    call add(resultLines, strpart(tmpColSplitLineStr, 1, strlen(tmpColSplitLineStr) - 1))

    " deal with the table body
    let index = 1
    while index < len(allLines)
        let curLine = allLines[index]
        let valList = split(curLine, '\t', 1)
        call add(resultLines, GenerateAMarkdownTableRowFunc(valList))
        let index = index + 1
    endwhile

    " join all lines
    let resultStr = join(resultLines, "\n")
    " replace content of current buffer
    let @u = resultStr
	execute a:start . ',' . a:end . 'd' 
	execute "put u"
    echo "Markdown table converted!"
endfunction
command -range Mdtable exec GenerateMarkdownTable(<line1>,<line2>)
