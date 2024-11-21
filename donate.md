---
layout: page
title: 赞助
---


<h1>赞助</h1>
<p>如果您觉得我的内容对您有帮助，可以考虑请我喝一杯咖啡。</p>

<div class="donation">
  <div class="paypal">
    <a href="https://paypal.me/otfocc" target="_blank">
      <img src="https://www.paypalobjects.com/webstatic/mktg/logo/pp_cc_mark_111x69.jpg" alt="PayPal 支付" />
    </a>
  </div>
  <small>点击图片，进入 PayPal 页面</small>
  <div class="qr-container">
    <div class="qrcode">
      <img src="{{ '/assets/img/alipay-qrcode.png' | relative_url }}" alt="支付宝二维码" />
    </div>
    <div class="qrcode">
      <img src="{{ '/assets/img/wechat-qrcode.png' | relative_url }}" alt="微信二维码" />
    </div>
  </div>
  <small>截图网页，打开App扫码</small>
</div>

<style>
  .donation {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 20px;
    margin-bottom: 40px; /* 间距调整 */
  }
  .qr-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
  }
  .qrcode {
    text-align: center;
    margin: 5px;
  }
  .qrcode img {
    width: 100%; 
    border-radius: 13px; /* 圆角边框 */
    border: 2px solid #ddd;
    padding: 0px;
    background-color: #fff;
  }
  .paypal {
    text-align: center;
    padding: 20px;
  }
  .paypal img {
    width: 80%;
  }
</style>