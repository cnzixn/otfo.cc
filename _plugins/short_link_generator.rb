require 'digest'
require 'yaml'

module Jekyll
  class ShortLinkGenerator < Generator
    safe true

    SHORTLINK_FILE = "_data/shortlinks.yml" # 短链接存储文件路径

    def generate(site)
      # 加载现有短链接数据
      shortlinks = load_shortlinks

      # 短链接固定在根目录
      root_url = site.config['url']

      # 遍历所有文章
      site.posts.docs.each do |post|
        short_code = get_or_generate_short_code(post, shortlinks)

        # 更新短链接数据到文章，确保短链接 URL 不包含 baseurl
        post.data["short_url"] = "#{root_url}/s/#{short_code}"

        # 生成短链接页面，忽略 baseurl
        create_redirect_page(site, short_code, File.join(root_url, site.config['baseurl'], post.url))
      end

      # 保存短链接数据到文件
      save_shortlinks(shortlinks)
    end

    private

    # 加载现有短链接数据
    def load_shortlinks
      unless File.exist?(SHORTLINK_FILE)
        dir = File.dirname(SHORTLINK_FILE)
        Dir.mkdir(dir) unless Dir.exist?(dir)
        File.open(SHORTLINK_FILE, "w") { |file| file.write({}.to_yaml) }
      end
      YAML.load_file(SHORTLINK_FILE) || {}
    end

    # 保存短链接数据到文件
    def save_shortlinks(shortlinks)
      File.open(SHORTLINK_FILE, "w") { |file| file.write(shortlinks.to_yaml) }
    end

    # 获取或生成短链接码
    def get_or_generate_short_code(post, shortlinks)
      if post.data["scode"]
        short_code = post.data["scode"]
      elsif shortlinks.key?(post.id)
        short_code = shortlinks[post.id]
      else
        short_code = generate_short_code(post.basename, shortlinks.values)
        shortlinks[post.id] = short_code
      end

      if shortlinks.value?(short_code) && shortlinks[post.id] != short_code
        Jekyll.logger.error("ShortLinkGenerator:", "Duplicate scode detected for post: #{post.data['title']}")
        raise "Duplicate scode: #{short_code}"
      end

      shortlinks[post.id] = short_code
      short_code
    end

    # 生成短链接码，确保唯一
    def generate_short_code(input, existing_short_codes)
      loop do
        short_code = "a" + Digest::MD5.hexdigest(input)[0, 5].downcase
        break short_code unless existing_short_codes.include?(short_code)
        input += rand(10).to_s
      end
    end

    # 创建跳转页面，确保短链接页面在根目录生成
    def create_redirect_page(site, short_code, source_url)
      # 将短链接页面直接放在根目录的 /s/short_code
      page = Jekyll::Page.new(site, site.source, "s", "#{short_code}/index.html")
      page.data["layout"] = "short"
      page.data["source_url"] = source_url
      site.pages << page
    end
  end
end