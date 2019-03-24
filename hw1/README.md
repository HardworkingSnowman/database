# [HW1](HW1.pdf) 新手教學
## 作業要求使用 Ubuntu server
1. [VirtualBox](https://123.briian.com/forum.php?mod=viewthread&tid=553) 下載虛擬機
2. [Ubuntu server](https://www.ubuntu.com/download/server) 下載Ubuntu iso檔
3. 打開虛擬機 => 新增 => linux, ubuntu 64 => 看自己要用多少空間 => 匯入影像檔選擇剛剛下載的 ubuntu iso => 啟動 => 接著瘋狂下一步

## 建議使用 ssh (這步不一定要做)
1. VirtualBox 內 => 設定 => 網路 => 進階設定 => 新增規則 => 分別填入 ssh, tcp, 127.0.0.1, 22, 10.0.2.15, 22 => 確定
2. 打開命令提示字元cmd(windows) or Terminal(Mac) => ssh [你的 ubuntu user name]@127.0.0.1 -p 22 => 打密碼

## 安裝 docker
在 ssh 過去的地方(Terminal):
```
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce
```

## 把作業提供的 mathc.csv, player_statistic.csv 傳上去
1. 到本機，打開cmd Or Terminal => cd 到你存放 match.csv 和 player_statistic.csv 的地方 => scp -P 22 match.csv player_statistic.csv [ubuntu user name]@127.0.0.1/home/[ubuntu user name]
2. 再 ssh 到虛擬機 => cd /home/[ubuntu user name] => ls => 應該會看到 match.csv, player_statistic

* 如果遇到 Permission denied: 到 ssh 後的 Terminal，chmod 777 /home/[ubuntu user name]，之後再執行步驟 1, 2。

## 安裝 MYSQL
1. docker run --name [MYSQL_user_name] -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:5.7
2. docker run [MYSQL_user_name]
3. docker run -it --link [MYSQL_user_name] -v `pwd`:/data --rm mysql:5.7 sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
* 前三個步驟完成，應該會看到 mysql>
* [MYSQL_user_name] 是你自己取的名字
* 之後要啟動 docker，只要步驟 2, 3就可以了
* ctrl+d = 離開, ctrl+c = 終止命令

## 開始做作業
在 ssh 過去的地方:
```
cd /home/[ubuntu user name]
docker run [MYSQL_user_name]
docker run -it --link [MYSQL_user_name] -v `pwd`:/data --rm mysql:5.7 sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR"
```

1. 建立資料庫
```
CREATE DATABASE [database name];
```

2. 建立兩張 table 分別給 match.csv 和 player_statistic.csv
```
CREATE TABLE `match`(
`matchId` char(100), 
`matchDuration` int,
`matchType` char(100),
`maxPlace` int,
`numGroup` int);

CREATE TABLE `player_statistic`(
`Id` char(100),
`groupId` char(100),
`matchId` char(100),
`assists` int,
`boosts` int,
`damageDealt` double,
`DBNOs` int,
`headshotKills` int,
`heals` int,
`killPlace` int,
`killPoints` int,
`kills` int,
`killStreaks` int,
`longestKill` double,
`randPoints` int,
`revives` int,
`rideDistance` double,
`roadKills` int,
`swimDistance` double,
`teamKills` int,
`vehicleDestroys` int,
`walkDistance` double,
`weaponsAcquired` int,
`winPoints` int,
`winPlacePerc` double);
```

3. 把資料匯入 table
```
LOAD DATA LOCAL INFILE '/data/match.csv'
INTO TABLE `match`
CHARACTER SET UTF8
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/data/player_statistic.csv'
INTO TABLE `player_statistic`
CHARACTER SET UTF8
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

4. 建立 INDEX 加速查詢:
```
CREATE INDEX matchId ON `match` (`matchId`);
CREATE INDEX matchId ON `player_statistic` (`matchId`);
CREATE INDEX Id ON `player_statistic` (`Id`);
```

5. 第一提到第八題
* [第一題](q1.sql)
* [第二題](q2.sql)
* [第三題](q3.sql)
* [第四題](q4.sql)
* [第五題](q5.sql)
* [第六題](q6.sql)
* [第七題](q7.sql)
* [第八題](q8.sql)
* [bonus(請勿抄襲)](bonus.sql)

