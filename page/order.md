---
layout: page
---

<div id="iframe-container">
  <!-- 加载提示 -->
  <p id="loading-message">正在加载，请稍候...</p>

  <!-- iframe -->
  <!-- https://ym.ksjhaoka.com/pages/index/index?s=sP1DVwBz318941 -->
  <iframe src="https://172.lot-ml.com/Search/Index" 
    width="100%"
    height="618px"
    onload="document.getElementById('loading-message').style.display = 'none'; onIframeLoad();"
    onerror="document.getElementById('loading-message').innerText='加载失败，请刷新页面。';">
  </iframe>
</div>
