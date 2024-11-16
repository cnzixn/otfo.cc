// <script>
// 等待 DOM 加载完成后执行
document.addEventListener("DOMContentLoaded", function() {
  var tocList = document.getElementById("toc-list");
  var headings = document.querySelectorAll("h2, h3"); // 查找所有 h2 和 h3 标签

  // 遍历标题并生成目录项
  headings.forEach(function(heading, index) {
    var tocItem = document.createElement("li");
    var tocLink = document.createElement("a");
    tocLink.href = "#" + heading.id; // 使用标题的 id 作为链接锚点
    tocLink.textContent = heading.textContent; // 使用标题文本作为链接内容
    tocItem.appendChild(tocLink);
    tocList.appendChild(tocItem);
  });
});
// </script>