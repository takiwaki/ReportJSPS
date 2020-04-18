# 学振報告用CSVファイルを作成するスクリプト

以下の手順に従ってください．

## 1. 個別にDOIと発表を収集する

ファイルの名前と中身は以下の形式に従ってください．

### DOIを書いたファイル

ファイルの名前は`??-doifile.csv`としてください．`??`には自分の名前やバージョン，日付等をいれます．
このディレクトリに含まれる`M1-doifile.csv`を例として配り(M1はmember 1を意味)，編集してもらうと良いと思います．
`-doifile.csv`を拡張子のように扱うのでこの部分を変更しないでください．`-doifile_v2.csvの`ようにバージョンをいれないでください．

形式は以下のようにしてください．2行目は例です．

|DOI	|refereed?|open access?|international collaboration?|comment|
|----|----|----|----|----|
|http://dx.doi.org/10.1093/ptep/ptx093|yes|no|no|Nakano2017|


### 発表を書いたファイル
ファイルの名前は`??-prefile.csv`としてください．`??`には自分の名前やバージョン，日付等をいれます．
`M1-prefile.csv`を例として配り，更新してもらうと良いと思います．
`-prefile.csv`を拡張子のように扱うのでこの部分を変更しないでください．`-prefile_v2.csv`のようにバージョンをいれないでください．

形式は以下のようにしてください．Year toは年をまたがない限り省略可能です．複数の発表者はセミコロンで区切ると良いです．

|Presenter|Title|Conference|Year from|Year to|invited?|international conference?|
|----|----|----|----|----|----|----|
|滝脇知也|ランキン-ユゴニオ関係でみる超新星の衝撃波復活機構|衝撃波研究会|2018| |yes|no|
|Tomoya Takiwaki;  Kei Kotake|C01 progress report|The first annual symposium of the innovative area "Gravitational Wave Physics and Astronomy: Genesis"	|2018|	|yes|	yes|


## 2. スクリプトで処理

以下では内部で`curl`,`python`,`nkf`を使うのでインストールしてください．

`Makefile`を開いて`project`に集計したいプロジェクトの名前を書いてください．defaultは`Summary`になっています．
つぎに`members`に集めたファイルの先頭部分を書いてください．`M1-doifile.csv`を集めたなら`M1`です．

	
	# Name of the Project
	project=Summary
	
	# Name of the Members, prefix for the files
	members=M1 M2
	

例としてある更新されてないM1-doifile.csv,M2-doifile.csv,M1-prefile.csv,M2-prefile.csvが残っている場合はここで消去してください．

問題なければ`make`で終わります．インターネットにつながった環境で行ってください．`project名-articles.csv`と`project名-presentations.csv`ができます．

	make


問題が起きた場合は`curl`,`python`がインストールされているかチェックしてください．

### ノート

`doi-convt.sh`の中では`curl`でDOIから論文の情報を取り寄せます．ただし，この論文の情報はutf-8で書かれています．
一方，学振への提出(というかエクセルファイルの仕様)はsjisの出力を求めています．
そこでsjisに直せないウムラウトなどの特殊文字を普通のアルファベットに変換するのが`DeleteUmlaut.py`です．
その処理をした後，全体をsjisに変換し最終出力としています．

## 3. 重複をチェック

出来た`project名-articles.csv`と`project名-presentations.csv`で重複を消してください．これはエクセル等で並び替えるのがわかりやすいです．

## 4. 学振に提出

あとは学振に提出してください．

## 参考文献

- [Get metadata from DOI](https://stackoverflow.com/questions/10507049/get-metadata-from-doi)
- [JSPS](https://www-shinsei.jsps.go.jp/kaken/topkakenhi/download-ka.html#tebiki3)

## 謝辞

このスクリプトは新学術領域「重力波創世記」の成果報告のために作成しました．
