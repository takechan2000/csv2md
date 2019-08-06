# csv2md
command for linux to translate csv data to table in markdown. It is written by Perl. 

## Usage
    csv2md [-f option] table.csv or cat table.csv |csv2md [-f option]
    
## Option
    [rcl]+
For example,
    > cat table.csv
    value1, value2, value3
    a, b, c
    aaa, bbb, ccc
    > csv2md -f rcl table.csv
    !value1|value2|value3|
    |----:|:---:|:----|
    |a|b|c|
    |aaa|bbb|ccc|
    >
    

