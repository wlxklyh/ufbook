/**
 * 广告加载管理脚本
 * 功能：
 * 1. 异步加载广告脚本，避免阻塞页面渲染
 * 2. 监控广告加载状态
 * 3. 处理广告加载失败情况
 * 4. 响应式广告尺寸调整
 */

(function() {
  'use strict';

  // 配置
  const AD_CONFIG = {
    loadTimeout: 5000, // 广告加载超时时间（毫秒）
    retryAttempts: 2,  // 重试次数
    retryDelay: 1000   // 重试延迟（毫秒）
  };

  // 广告加载状态管理
  class AdLoader {
    constructor() {
      this.adSlots = [];
      this.loadedAds = new Set();
      this.failedAds = new Set();
      this.init();
    }

    init() {
      // 等待 DOM 加载完成
      if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => this.loadAds());
      } else {
        this.loadAds();
      }

      // 监听页面可见性变化
      document.addEventListener('visibilitychange', () => {
        if (!document.hidden) {
          this.checkAdVisibility();
        }
      });

      // 监听窗口大小变化，调整广告尺寸
      window.addEventListener('resize', this.debounce(() => {
        this.adjustAdSizes();
      }, 250));
    }

    loadAds() {
      // 查找所有广告位
      this.adSlots = Array.from(document.querySelectorAll('.ad-slot'));
      
      if (this.adSlots.length === 0) {
        console.log('No ad slots found');
        return;
      }

      console.log(`Found ${this.adSlots.length} ad slot(s)`);

      // 使用 Intersection Observer 实现懒加载
      this.setupLazyLoading();
    }

    setupLazyLoading() {
      const observerOptions = {
        root: null,
        rootMargin: '200px', // 提前 200px 开始加载
        threshold: 0.01
      };

      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            const adSlot = entry.target;
            const adId = adSlot.id;

            if (!this.loadedAds.has(adId) && !this.failedAds.has(adId)) {
              this.loadAd(adSlot);
              observer.unobserve(adSlot);
            }
          }
        });
      }, observerOptions);

      this.adSlots.forEach(slot => {
        observer.observe(slot);
      });
    }

    loadAd(adSlot, attempt = 1) {
      const adId = adSlot.id;
      console.log(`Loading ad: ${adId} (attempt ${attempt})`);

      // 设置加载超时
      const timeoutId = setTimeout(() => {
        if (!this.loadedAds.has(adId)) {
          console.warn(`Ad load timeout: ${adId}`);
          this.handleAdError(adSlot, attempt);
        }
      }, AD_CONFIG.loadTimeout);

      // 监听广告加载成功
      const checkAdLoaded = setInterval(() => {
        // 检查广告容器内是否有内容
        const hasContent = adSlot.querySelector('iframe') || 
                          adSlot.querySelector('ins') ||
                          (adSlot.children.length > 0 && adSlot.offsetHeight > 50);

        if (hasContent) {
          clearInterval(checkAdLoaded);
          clearTimeout(timeoutId);
          this.handleAdLoaded(adSlot);
        }
      }, 500);

      // 5秒后停止检查
      setTimeout(() => {
        clearInterval(checkAdLoaded);
      }, AD_CONFIG.loadTimeout);
    }

    handleAdLoaded(adSlot) {
      const adId = adSlot.id;
      console.log(`Ad loaded successfully: ${adId}`);
      
      this.loadedAds.add(adId);
      adSlot.classList.add('loaded');
      adSlot.classList.remove('loading', 'error');

      // 触发自定义事件
      const event = new CustomEvent('adLoaded', { detail: { adId } });
      document.dispatchEvent(event);
    }

    handleAdError(adSlot, attempt) {
      const adId = adSlot.id;

      // 重试机制
      if (attempt < AD_CONFIG.retryAttempts) {
        console.log(`Retrying ad load: ${adId}`);
        setTimeout(() => {
          this.loadAd(adSlot, attempt + 1);
        }, AD_CONFIG.retryDelay);
        return;
      }

      // 标记为失败
      console.error(`Ad failed to load: ${adId}`);
      this.failedAds.add(adId);
      adSlot.classList.add('error');
      adSlot.classList.remove('loading');

      // 触发自定义事件
      const event = new CustomEvent('adError', { detail: { adId } });
      document.dispatchEvent(event);

      // 可选：隐藏失败的广告位
      // adSlot.style.display = 'none';
    }

    checkAdVisibility() {
      // 页面重新可见时，检查广告是否正常显示
      this.adSlots.forEach(slot => {
        const adId = slot.id;
        if (this.loadedAds.has(adId)) {
          const hasContent = slot.offsetHeight > 50;
          if (!hasContent) {
            console.warn(`Ad disappeared: ${adId}`);
            this.loadedAds.delete(adId);
            slot.classList.remove('loaded');
          }
        }
      });
    }

    adjustAdSizes() {
      // 根据屏幕尺寸调整广告容器
      const viewportWidth = window.innerWidth;
      
      this.adSlots.forEach(slot => {
        if (slot.classList.contains('ad-slot--banner')) {
          // 横幅广告响应式调整
          if (viewportWidth < 768) {
            slot.style.maxWidth = '100%';
          } else if (viewportWidth < 1024) {
            slot.style.maxWidth = '728px';
          } else {
            slot.style.maxWidth = '970px';
          }
        }
      });
    }

    // 工具函数：防抖
    debounce(func, wait) {
      let timeout;
      return function executedFunction(...args) {
        const later = () => {
          clearTimeout(timeout);
          func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
      };
    }
  }

  // 初始化广告加载器
  const adLoader = new AdLoader();

  // 暴露到全局（可选，用于调试）
  window.adLoader = adLoader;

  // 监听广告加载事件（可选，用于统计）
  document.addEventListener('adLoaded', (e) => {
    console.log('Ad loaded event:', e.detail);
    // 可以在这里发送统计数据
  });

  document.addEventListener('adError', (e) => {
    console.log('Ad error event:', e.detail);
    // 可以在这里发送错误报告
  });

})();

