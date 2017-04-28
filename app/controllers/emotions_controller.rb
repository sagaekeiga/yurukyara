class EmotionsController < ApplicationController

    #感情基準値をデータベースへ格納
    def em_dic
      # 'db.txt'は上記データベースをテキストファイルに保存したテキストファイル
      list_db = Array.new
      File.open('db.txt', 'r') do |file|
          file.each{ |line|
              @emo = Emotion.new
              # 単語
              @emo[:word] = line.chomp.split(':')[0]
              # 読み
              @emo[:reading] = line.chomp.split(':')[1]
              # 品詞
              @emo[:pos] = line.chomp.split(':')[2]
              # 感情値
              @emo[:semantic_orientations] = line.chomp.split(':')[3]
              
              @emo.save
      
              p list_db << @emo
          }
          
          
          list_db.each do |line|
              p line[:word]
          end
      end
    end
    
    
    def analysis
        @input = Dictionary.last.word
        @sum = params[:sum]
        # インプット格納用配列
        list_tweets = Array.new
        # 配列にツイート格納
        p list_tweets << @input
        
        # 形態素解析したものを格納
        list_morph = Array.new
        
        # ツイートを格納した配列の展開
        list_tweets.each{ |e|
            tmp = Array.new

            nm = Natto::MeCab.new
            nm.parse(e.encode("UTF-8")) do |n|
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
            #--------------------------------形態素解析の配列
            p list_morph.push tmp
        }
        
        
        #---------------　感情値算出

        # 感情値格納用配列
        list_semantic = Array.new
        
        # 形態素解析結果を格納した配列から各ツイートの形態素解析結果に展開
        list_morph.each{ |e|
            tmp = Array.new
            e.each{ |h|
                @emotions = Emotion.all
                @emotions.each{ |line|
                    # 単語、読み、品詞が一致の場合、感情値をカウント
                    if h[:word] == line[:word] and h[:reading] == line[:reading] and h[:pos] == line[:pos] then
                        tmp.push line[:semantic_orientations]
                    end
                }
            }
            # カウントした感情値の平均値
            p semantic_ave = tmp.inject(0){ |sum, i| sum += i.to_f} / tmp.size unless tmp.size == 0

            
            if !semantic_ave.nil?
                @sum = @sum.to_d + 0.1
                @sum += semantic_ave.to_d
            end
            
            p list_semantic.push semantic_ave
        }
        redirect_to pages_index_path(sum: @sum)
    end
    
end
