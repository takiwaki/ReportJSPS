# 学振報告用CSVファイルを作成するスクリプト

以下の手順に従ってください．内部でcurlとpython を使うのでインストールしてください．

## 個別にDOIと発表を収集する

ファイルの名前と中身は以下の形式に従ってください．

### DOIを書いたファイル
ファイルの名前は??-doifile.csvとしてください．?? には自分の名前等をいれます．
形式は以下のようにしてください．2行目は例です．

|DOI	|refereed?|open access?|international collaboration?|comment|
|----|----|----|----|----|
|http://dx.doi.org/10.1093/ptep/ptx093|yes|no|no|Nakano2017|

### 発表を書いたファイル
ファイルの名前は??-prefile.csvとしてください．?? には自分の名前等をいれます．
形式は以下のようにしてください．Year toは年をまたがない限り省略可能です．

|Presenter|Title|Conference|Year from|Year to|invited?|international conference?|
|----|----|----|----|----|----|----|
|滝脇知也|ランキン-ユゴニオ関係でみる超新星の衝撃波復活機構|衝撃波研究会|2018| |yes|no|
|Tomoya Takiwaki;  Kei Kotake|C01 progress report|The first annual symposium of the innovative area "Gravitational Wave Physics and Astronomy: Genesis"	|2018|	|yes|	yes|

## スクリプトで処理

Makefileを開いてprojectに集計したいプロジェクトの名前を書いてください．defaultはSummaryになっています．
つぎにmembersに集めたファイルの先頭部分を書いてください．M1-doifile.csvを集めたならM1です．

問題なければmakeで終わります．project名-articles.csvとproject名-presentations.csvができます．

問題が起きた場合はcurl,pythonがインストールされているかチェックしてください．

## 重複をチェック

出来たproject名-articles.csvとproject名-presentations.csvで重複を消してください．これはエクセル等で並び替えるのがわかりやすいです．

## 学振に提出

あとは学振に提出してください．
