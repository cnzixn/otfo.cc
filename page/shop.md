---
layout: page
---

<div id="iframe-container">
  <!-- 加载提示 -->
  <p id="loading-message">正在加载，请稍候...</p>

  <!-- iframe -->
  <iframe src="https://172.lot-ml.com/ProductEn/Index/6babd1bdd232e810" 
    width="100%"
    height="618px"
    onload="document.getElementById('loading-message').style.display = 'none'; onIframeLoad();"
    onerror="document.getElementById('loading-message').innerText='加载失败，请刷新页面。';">
  </iframe>
</div>
