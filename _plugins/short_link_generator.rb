require 'digest'
require 'json'

module Jekyll
  class ShortLinkGenerator < Generator
    priority :high  # 提高插件优先级

    def generate(site)
      # 确保 _pages 中的页面文件被加载
      site.collections["pages"].docs.each do |page|
        # 跳过已经生成的短链接页面
        next if page.path.include?("/s/") || page.data["is_short_link"]

        # 确定短链接代码
        file_name = File.basename(page.path, File.extname(page.path)) # 获取文件名，去掉扩展名
        short_code = if page.data["scode"]
                       page.data["scode"]
                     else
                       # 使用文件名生成短链接代码
                       "a" + Digest::MD5.hexdigest(file_name)[0, 5].downcase
                     end

        # 创建短链接的 URL
        short_url = "#{site.config['url']}/s/#{short_code}"

        # 添加短链接到页面数据
        page.data["short_url"] = short_url

        # 生成中转页面
        short_link_page = Jekyll::Page.new(site, site.source, "", "s/#{short_code}.html")
        short_link_page.data["layout"] = "short"  # 使用跳转样式的布局
        short_link_page.data["source_url"] = "#{site.config['url']}#{site.config['baseurl']}#{page.url}"
        short_link_page.data["is_short_link"] = true  # 标记为短链接页面，避免重复处理

        # 添加中转页面到站点
        site.pages << short_link_page
      end
    end
  end
end