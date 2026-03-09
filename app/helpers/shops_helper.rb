module ShopsHelper
  def instagram_embed_tag(url)
    return if url.blank?
    
    # URLの末尾を調整して埋め込み用URLにする
    embed_url = url.end_with?('/') ? "#{url}embed" : "#{url}/embed"
    
    content_tag(:iframe, '', 
      src: embed_url,
      width: 400,
      height: 480,
      frameborder: 0,
      scrolling: 'no',
      allowtransparency: 'true',
      style: "border:none; overflow:hidden; border-radius:10px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);"
    )
  end
end