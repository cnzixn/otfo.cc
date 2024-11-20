require 'digest'

module Jekyll
  class ShortLinkGenerator < Generator
    priority :high  # 提高插件优先级

    def generate(site)
      site.posts.docs.each do |post|
        # 确定短链接代码
        short_code = if post.data["scode"]
                       post.data['scode']
                     else
                       file_name = post.basename
                       "a" + Digest::MD5.hexdigest(file_name)[0, 5].downcase
                     end

        # 添加短链接到文章数据
        post.data["short_url"] = "#{site.config['url']}/s/#{short_code}"

        # 生成中转页面
        short_link_page = Jekyll::Page.new(site, site.source, "", "s/#{short_code}/index.html")
        short_link_page.data["layout"] = "short"
        short_link_page.data["source_url"] = "#{site.config['url']}#{site.config['baseurl']}#{post.url}"

        # 添加中转页面到站点
        site.pages << short_link_page
      end
    end
  end
end