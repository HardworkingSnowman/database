# 2019 NCTU DATABASE hw2
## 一、前置作業
1. 下載 google test
* 從 git 抓 google test
```
sudo git clone https://github.com/google/googletest.git
cd googletest
mkdir mybuild
cd mybuild
sudo cmake ..
make
sudo make install
```
* 測試是否成功
```
先:
vim sample_test.c

再複製下面這些進去:
#include <stdio.h>
#include "gtest/gtest.h"

int main(int argc, char **argv) {
    int iret;
    testing::InitGoogleTest(&argc, argv);
    iret = RUN_ALL_TESTS();
    return iret;
}               

TEST(sampleTest, demo) {
    ASSERT_EQ(1+1, 2);
}

最後:
g++ -o sample_test sample_test.c -lgtest -pthread -std=c++11
./sample_test

如果出現綠色的 RUN OK PASSED 就表示 OK 了
```

2. 把作業用 git 下載下來
```
sudo git clone https://github.com/Billy4195/simple_DBMS.git
```

3. 編譯 simpleDBMS
```
cd simpleDBMS
make
```

4. 測試 simpleDBMS
```
在 simpleDBMS 目錄中
make check

python3 test/system/system_test.py ./shell
會看到很多需要 implement 的部分

./shell
會看到 db >

db > .help 
會看到很多指令教學

db > .exit
離開
```