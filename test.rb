require 'tweetstream'
require 'natto'

# Twitter APIのキー設定
TweetStream.configure do |config|
    config.consumer_key        = "5UsgucSdL9yzkHLdpxGTthfBg"
    config.consumer_secret     = "g8n1QPviyy6bpG55MkbLh9g6QfKV2aKl1ZQEJ6VUXLTeSuAsch"
    config.oauth_token = '838030459871223811-wlz0KWpsigG7YDu0BXAwUsw1j3lSpTk'
    config.oauth_token_secret = 'uSxO2FcYAO50RUzvZvoxrFsH1r32qmdDXr4xuxQhGcHcw'
    config.auth_method = :oauth
end

# ツイート格納用配列
list_tweets = Array.new

# ツイート取得
TweetStream::Client.new.sample do |status, client|
    # 言語設定が「日本語」かつ、リツイート以外のツイートかつ、リプライでないツイートを抽出
    if status.user.lang == "ja" && !status.text.index("RT") && status.in_reply_to_user_id.nil? then

        h = Hash.new
        # 日付
        h['date'.to_sym] = status.created_at
        # スクリーンネーム
        h['screen_name'.to_sym] = "@" + status.user.screen_name
        # ツイート
        h['tweet'.to_sym] = status.text

        # 配列にツイート格納
        p list_tweets << h

        # 取得ツイート数が100以上でストップ
        client.stop if list_tweets.size >= 20
        

        list_morph = Array.new
        
        # ツイートを格納した配列の展開
        list_tweets.each{ |e|
            tmp = Array.new
        
            # 解析前に行う文字の正規化処理（上記リファレンスのソースコードを使用させていただきました）
            text = normalize_neologd "#{e[:tweet]}"
        
            nm = Natto::MeCab.new(dicdir: "/opt/local/lib/mecab/dic/mecab-ipadic-neologd")
            nm.parse(text.encode("UTF-8")) do |n|
                next if n.is_eos?
        
                h = Hash.new
                # 表層形
                h['word'.to_sym] = n.surface
                # 読み
                h['reading'.to_sym] = n.feature.split(',')[-2].tr('ァ-ン', 'ぁ-ん')
                # 品詞
                h['pos'.to_sym] = n.feature.split(',')[0]
        
                p tmp << h
            end
        
            list_morph.push tmp
        }

    end

    list_db = Array.new
    
    # 'db.txt'は上記データベースをテキストファイルに保存したテキストファイル
    File.open('db.txt', 'r') do |file|
        file.each{ |line|
            h = Hash.new
            # 単語
            h['word'.to_sym] = line.chomp.split(':')[0]
            # 読み
            h['reading'.to_sym] = line.chomp.split(':')[1]
            # 品詞
            h['pos'.to_sym] = line.chomp.split(':')[2]
            # 感情値
            h['semantic_orientations'.to_sym] = line.chomp.split(':')[3]
    
            p list_db << h
        }
    end
    
    # 感情値格納用配列
    list_semantic = Array.new
    
    # 形態素解析結果を格納した配列から各ツイートの形態素解析結果に展開
    list_morph.each{ |e|
        tmp = Array.new
        e.each{ |h|
            list_db.each{ |line|
                # 単語、読み、品詞が一致の場合、感情値をカウント
                if h[:word] == line[:word] and h[:reading] == line[:reading] and h[:pos] == line[:pos] then
                    tmp.push line[:semantic_orientations]
                end
            }
        }
        # カウントした感情値の平均値
        semantic_ave = tmp.inject(0){ |sum, i| sum += i.to_f} / tmp.size unless tmp.size == 0
    
        p list_semantic.push semantic_ave
    }
end