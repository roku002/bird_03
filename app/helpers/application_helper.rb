module ApplicationHelper
  def page_title(title = '')
    base_title = 'BIRD APP' 
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def default_meta_tags
    {
      site: 'Buncho-Lover',
      title: '文鳥好きの写真投稿や質問掲示板サービス',
      reverse: true,
      charset: 'utf-8',
      description: 'Buncho-Loberでは、文鳥の写真の投稿や、質問、雑談掲示板などを建てることが出来ます。',
      keywords: '文鳥,鳥,小鳥,手乗り',
      canonical: https://first-app-bird-e6fdc1b0fdf3.herokuapp.com/,
      separator: '|',
      og:{
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: https://first-app-bird-e6fdc1b0fdf3.herokuapp.com/,
        image: image_url('tori.jpg'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードに変更
        site: '#', # アプリの公式Twitterアカウントがあれば、アカウント名を記載
        image: image_url('tori.jpg'),# 配置するパスやファイル名によって変更
      }
    }
  end
end
