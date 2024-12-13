require 'digest'
require 'json'

module Jekyll
  class ShortLinkGenerator < Generator
    priority :high # 提高插件优先级

    REDIRECTS_FILE = 'short.json' # JSON 文件保存位置

    def generate(site)
      # 加载现有的短链接映射或初始化为空
      short_links = load_existing_redirects

      site.posts.docs.each do |post|
        # 确定短链接代码
        short_code = if post.data["scode"]
                       post.data["scode"]
                     else
                       file_name = post.basename
                       "a" + Digest::MD5.hexdigest(file_name)[0, 5].downcase
                     end

        # 更新短链接映射
        short_links[short_code] = "#{site.config['baseurl']}#{post.url}"

        # 添加短链接到文章数据
        post.data["short_url"] = "#{site.config['url']}/s/#{short_code}"

        # 生成中转页面
        short_link_page = Jekyll::Page.new(site, site.source, "", "s/#{short_code}.html")
        short_link_page.data["layout"] = "short" # 指定跳转样式的布局
        short_link_page.data["source_url"] = "#{site.config['url']}#{site.config['baseurl']}#{post.url}"

        # 添加中转页面到站点
        site.pages << short_link_page
      end

      # 更新或保存 short.json 文件
      # save_redirects_json(short_links)
    end

    private

    # 加载现有的 JSON 文件，如果不存在，则返回一个空哈希
    def load_existing_redirects
      if File.exist?(REDIRECTS_FILE)
        # 如果文件存在，读取并解析内容
        JSON.parse(File.read(REDIRECTS_FILE))
      else
        # 如果文件不存在，返回一个空的映射
        {}
      end
    end

    # 保存更新后的 JSON 文件
    def save_redirects_json(short_links)
      # 将更新后的短链接映射写入 short.json 文件
      File.open(REDIRECTS_FILE, 'w') do |file|
        file.write(JSON.pretty_generate(short_links))
      end
      Jekyll.logger.info "ShortLinkGenerator:", "Updated #{REDIRECTS_FILE}"
    end
  end
end