class SearchController < ApplicationController

    def target_select
        # 検索データをsessionに入れて直してindexに渡す
        session[:word_params] = params[:word]
        session[:method_params] = params[:method]
        # targetの値によってpathを変更する
        target = params[:target]
        if target == "Users"
            redirect_to users_path
        elsif target == "Books"
            redirect_to books_path
        end
    end

end
