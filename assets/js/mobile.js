
  // 检测是否为手机设备
  function isMobile() {
    return /Mobi|Android|iPhone|iPad|iPod|webOS|BlackBerry|IEMobile|Opera Mini/i.test(window.navigator.userAgent);
  }

  // 判断当前页面是否为 404 页面
  function is404Page() {
    // 判断当前页面的 URL 或某些特定的元素来识别是否是 404 页面
    // 假设 404 页面 URL 为 "/404" 或页面中含有 "404" 的文本
    return window.location.pathname === '/404' || document.body.innerHTML.indexOf('404') > -1;
  }

  // 如果不是手机设备且当前页面不是 404 页面，跳转到 404 页面
  if (!isMobile() && !is404Page()) {
    window.location.href = "/404";  // 跳转到网站的 404 页面
  }


