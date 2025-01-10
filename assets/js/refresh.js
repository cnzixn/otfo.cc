let startY = 0; // 记录触摸起始点
let isAtTop = false; // 标记是否在页面最顶端
let refreshMessage = document.getElementById("refreshMessage"); // 获取提示元素

// 在页面最顶端时显示提示
window.addEventListener("touchstart", (event) => {
  // 判断页面是否在最顶端
  isAtTop = document.documentElement.scrollTop === 0;

  if (isAtTop) {
    // 记录触摸起始点的 Y 坐标
    startY = event.touches[0].clientY;
  }
});

// 监听触摸滑动
window.addEventListener("touchmove", (event) => {
  if (!isAtTop) {
    return; // 如果不在最顶端，不处理逻辑
  }

  const currentY = event.touches[0].clientY;
  const distance = currentY - startY;

  // 判断滑动方向，如果是向下滑动并且距离超过 20% 屏幕高度，则更新提示内容
  if (distance > 0) { // 只处理向下滑动
    if (distance > window.innerHeight * 0.2) {
      refreshMessage.innerHTML = "<p>释放以刷新页面</p>"; // 更新提示内容
    } else if (distance > window.innerHeight * 0.01) {
      refreshMessage.innerHTML = "<p>继续下拉，刷新页面...</p>"; // 恢复提示内容
      // 显示提示
      refreshMessage.classList.add("visible");
      refreshMessage.classList.remove("hidden");
    }
  }
});

// 监听触摸结束事件
window.addEventListener("touchend", (event) => {
  if (isAtTop && startY) {
    const currentY = event.changedTouches[0].clientY;
    const distance = currentY - startY;

    // 如果下拉超过 30% 高度，则刷新页面
    if (distance > window.innerHeight * 0.2) {
      // 获取当前的 URL
      const currentUrl = new URL(window.location.href);
      
      // 获取当前时间并格式化为 YYYYMMDDHHMMSS
      const now = new Date();
      const formattedTime = now.getFullYear() + 
                            ('0' + (now.getMonth() + 1)).slice(-2) + 
                            ('0' + now.getDate()).slice(-2) + 
                            ('0' + now.getHours()).slice(-2) + 
                            ('0' + now.getMinutes()).slice(-2) + 
                            ('0' + now.getSeconds()).slice(-2);
      
      // 更新 v 参数
      currentUrl.searchParams.set('v', formattedTime);
      
      // 刷新页面，并更新 URL
      window.location.href = currentUrl.toString(); // 刷新页面并更新 URL

      // 不再执行后续代码
      return;
    }

    // 隐藏提示
    refreshMessage.classList.add("hidden");
    refreshMessage.classList.remove("visible");
  }
});

