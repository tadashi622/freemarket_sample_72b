crumb :root do
  link "トップページ", root_path
end

crumb :mypage do
  link "マイページ", user_path(current_user.id)
  parent :root
end

crumb :card do
  link "支払い方法", card_user_path
  parent :mypage
end

crumb :edit_card do
  link "クレジットカード情報", edit_card_path
  parent :card
end


crumb :profile do
  link "プロフィール", profile_user_path
  parent :mypage
end

crumb :introduce do
  link "本人情報", introduce_user_path
  parent :mypage
end

crumb :address do
  link "発送元・お届け先の住所変更", address_user_path
  parent :mypage
end

crumb :edit_mail do
  link "メール・パスワード", edit_user_registration_path(current_user.id)
  parent :mypage
end

crumb :phone do
  link "電話番号", phone_user_path
  parent :mypage
end

crumb :sign do
  link "ログアウト", signout_users_path
  parent :mypage
end

crumb :show_product do
  link "商品詳細", product_path
  parent :root
end

crumb :list do
  link "商品一覧", products_list_products_path
  parent :root
end
# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).