---
layout: page
scode: search
---

<input type="text" class="search-input" placeholder="请输入关键词...">
<ul class="search-results"></ul>

<script>

  async function fetchPosts() {
    const response = await fetch("{{ site.baseurl }}/search.json");
    const posts = await response.json();
    displayResults(posts); // 页面加载时默认显示所有文章
    return posts;
  }

  function filterPosts(posts, query) {
    return posts.filter(post => {
      const content = `${post.title} ${post.tags} ${post.content}`.toLowerCase();
      return content.includes(query.toLowerCase());
    });
  }

  function displayResults(results) {
    const resultsContainer = document.querySelector(".search-results");
    resultsContainer.innerHTML = results.map(post => `
      <a href="${post.url}" class="search-card">
        <li>
          ${post.title}
          <small>${post.date} ${post.tags}</small>
        </li>
      </a>
    `).join('');
  }

  document.addEventListener("DOMContentLoaded", async () => {
    const posts = await fetchPosts(); // 页面加载时获取所有文章
    document.querySelector(".search-input").addEventListener("input", (event) => {
      const query = event.target.value.trim();
      const results = filterPosts(posts, query);
      displayResults(results);
    });
  });

</script>