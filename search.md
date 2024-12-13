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

  document.querySelector(".search-input").addEventListener("input", async (event) => {
    const query = event.target.value.trim();
    const posts = await fetchPosts();
    const results = filterPosts(posts, query);
    displayResults(results);
  });
</script>
