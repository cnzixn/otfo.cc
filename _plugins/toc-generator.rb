require 'cgi'

module Jekyll
  class TOCGenerator < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @content = text.strip
    end

    def render(context)
      # 获取页面内容
      content = context['page']['content']

      # 使用正则匹配 h1 和 h2 标签及其 id 和文本内容
      headings = content.scan(/<(h[1-6])[^>]*id=["']?([^"'>]*)["']?[^>]*>(.*?)<\/\1>/)

      # 初始化目录内容
      toc_content = "<ul>"

      # 循环处理每个匹配到的标题
      cur_level = 1
      headings.each do |heading|
        level = heading[0].gsub('h', '').to_i
        anchor = heading[1].strip
        title = heading[2].strip

        # 对 id 进行 URL 编码
        encoded_anchor = CGI.escape(anchor)

        # 调整目录的层级结构
        if level > cur_level
          (level - cur_level).times { toc_content += "<ul>" }
        elsif level < cur_level
          (cur_level - level).times { toc_content += "</ul>" }
        end

        toc_content += "<li class='post-toc-h#{level}'><a href='##{encoded_anchor}'>#{title}</a></li>"

        cur_level = level
      end

      # 关闭未闭合的 ul 标签
      (cur_level - 1).times { toc_content += "</ul>" }

      toc_content
    end
  end
end

# 注册自定义标签
Liquid::Template.register_tag('toc_content', Jekyll::TOCGenerator)