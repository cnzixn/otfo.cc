---
layout: page
---

<div class="home-page-content">

  <a href="/s/guide">新人指路</a>

  <a href="https://qun.qq.com/qqweb/qunpro/share?inviteCode=2jKeVdfLFtI">问题反馈</a>

  <a href="{{ '/section/posts' | absolute_url }}">更多帖子</a>

</div>



<script>
    // 实际上并未使用，保留仅供学习。
    async function redirectToPage() {
        // 获取 URL 参数
        const urlParams = new URLSearchParams(window.location.search);
        const key = urlParams.get('k');

        if (key) {
            try {
                // 加载 JSON 文件
                const response = await fetch('short.json'); // JSON 文件位于根目录
                const redirects = await response.json();

                // 查找对应页面并跳转
                if (redirects[key]) {
                    window.location.href = redirects[key];
                } else {
                    // alert('无效的参数值：' + key);
                }
            } catch (error) {
                console.error('加载跳转配置失败:', error);
            }
        } else {
            // 没有参数时显示主页内容
            document.getElementById('main-content').style.display = 'block';
        }
    }

    window.onload = redirectToPage;
</script>