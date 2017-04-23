class DictionariesController < ApplicationController
    require 'pp'
    require 'enumerator'


    def create
     p "--------------create"
     p @dic = params[:dictionary][:word]
     markov_dic(@dic)
    end
    
    
    #マルコフ辞書の作成
    def markov_dic(input)
        text = File.open('.//text.txt').read.gsub(/(\s)/,"")
    	
        # mecabで形態素解析して、 参照テーブルを作る
        mecab = Natto::MeCab.new("-Owakati")
        data = Array.new
        mecab.parse(text + "EOS").split(" ").each_cons(3) do |a| 
          data.push h = {'head' => a[0], 'middle' => a[1], 'end' => a[2]}
        end
        
        # マルコフ連鎖で要約

        while true
          num = rand(data.size) # 乱数で次の文節を決定する
          t1 = data[num]['head']
          t2 = data[num]['middle']
          t3 = data[num]['end']
          p "new_text = t1 + t2 + t3"
          p new_text = t1 + t2 + t3
          break if data[num]['end'] == "。"
        end
        
        # マルコフ生成文を保存
        @markov_res = new_text
        @markov_dic = Dictionary.new
        @markov_dic.word = @dic
        @markov_dic.res = @markov_res
        @markov_dic.save
        
        redirect_to pages_index_path
    end
    

      private
      
        def dictionary_params
          params.require(:dictionary).permit(:word)
        end
end
