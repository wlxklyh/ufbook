/**
 * 访问统计增强脚本
 * 功能：
 * 1. 自定义事件追踪
 * 2. 页面性能监控
 * 3. 用户行为分析
 */

(function() {
  'use strict';

  // 检查是否启用了统计
  const hasBaidu = typeof _hmt !== 'undefined';
  const hasGA = typeof gtag !== 'undefined';

  if (!hasBaidu && !hasGA) {
    console.log('Analytics not enabled');
    return;
  }

  // 统一的事件追踪函数
  function trackEvent(category, action, label, value) {
    // 百度统计
    if (hasBaidu) {
      _hmt.push(['_trackEvent', category, action, label, value]);
    }

    // Google Analytics
    if (hasGA) {
      gtag('event', action, {
        'event_category': category,
        'event_label': label,
        'value': value
      });
    }

    console.log('Event tracked:', { category, action, label, value });
  }

  // 追踪页面性能
  function trackPerformance() {
    if (window.performance && window.performance.timing) {
      window.addEventListener('load', function() {
        setTimeout(function() {
          const timing = performance.timing;
          const loadTime = timing.loadEventEnd - timing.navigationStart;
          const domReadyTime = timing.domContentLoadedEventEnd - timing.navigationStart;
          const renderTime = timing.domComplete - timing.domLoading;

          trackEvent('Performance', 'Page Load Time', 'milliseconds', loadTime);
          trackEvent('Performance', 'DOM Ready Time', 'milliseconds', domReadyTime);
          trackEvent('Performance', 'Render Time', 'milliseconds', renderTime);

          console.log('Performance tracked:', {
            loadTime: loadTime + 'ms',
            domReadyTime: domReadyTime + 'ms',
            renderTime: renderTime + 'ms'
          });
        }, 0);
      });
    }
  }

  // 追踪外链点击
  function trackOutboundLinks() {
    document.addEventListener('click', function(e) {
      const link = e.target.closest('a');
      if (!link) return;

      const href = link.getAttribute('href');
      if (!href) return;

      // 检查是否是外链
      const isOutbound = href.startsWith('http') && 
                        !href.includes(window.location.hostname);

      if (isOutbound) {
        trackEvent('Outbound Link', 'Click', href);
      }
    });
  }

  // 追踪代码复制
  function trackCodeCopy() {
    document.addEventListener('click', function(e) {
      const copyButton = e.target.closest('button[data-clipboard-text]');
      if (copyButton) {
        trackEvent('Code', 'Copy', 'Code Block');
      }
    });
  }

  // 追踪搜索行为
  function trackSearch() {
    const searchInput = document.querySelector('[data-md-component="search-query"]');
    if (searchInput) {
      let searchTimeout;
      searchInput.addEventListener('input', function(e) {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(function() {
          const query = e.target.value.trim();
          if (query.length > 2) {
            trackEvent('Search', 'Query', query);
          }
        }, 1000);
      });
    }
  }

  // 追踪文章阅读深度
  function trackReadingDepth() {
    let maxDepth = 0;
    const depths = [25, 50, 75, 100];
    
    window.addEventListener('scroll', function() {
      const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
      const scrollTop = window.scrollY;
      const currentDepth = Math.floor((scrollTop / scrollHeight) * 100);

      depths.forEach(function(depth) {
        if (currentDepth >= depth && maxDepth < depth) {
          maxDepth = depth;
          trackEvent('Reading', 'Scroll Depth', depth + '%', depth);
        }
      });
    });
  }

  // 追踪页面停留时间
  function trackTimeOnPage() {
    let startTime = Date.now();
    let isActive = true;
    let totalActiveTime = 0;

    // 监听页面可见性
    document.addEventListener('visibilitychange', function() {
      if (document.hidden) {
        if (isActive) {
          totalActiveTime += Date.now() - startTime;
          isActive = false;
        }
      } else {
        startTime = Date.now();
        isActive = true;
      }
    });

    // 页面卸载时发送数据
    window.addEventListener('beforeunload', function() {
      if (isActive) {
        totalActiveTime += Date.now() - startTime;
      }
      const timeInSeconds = Math.round(totalActiveTime / 1000);
      
      if (timeInSeconds > 5) {
        trackEvent('Engagement', 'Time on Page', 'seconds', timeInSeconds);
      }
    });
  }

  // 追踪移动端 vs 桌面端
  function trackDeviceType() {
    const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
    const deviceType = isMobile ? 'Mobile' : 'Desktop';
    trackEvent('Device', 'Type', deviceType);
  }

  // 初始化所有追踪功能
  function init() {
    trackPerformance();
    trackOutboundLinks();
    trackCodeCopy();
    trackSearch();
    trackReadingDepth();
    trackTimeOnPage();
    trackDeviceType();

    console.log('Analytics enhanced tracking initialized');
  }

  // DOM 加载完成后初始化
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  // 暴露追踪函数到全局（可选）
  window.trackEvent = trackEvent;

})();


