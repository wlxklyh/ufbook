/**
 * 广告集成脚本
 * 支持多种广告平台：Google AdSense、百度联盟、腾讯广告等
 */

(function() {
    'use strict';

    // 广告配置
    const AD_CONFIG = {
        // 是否启用广告
        enabled: true,
        // 广告平台：'google', 'baidu', 'tencent', 'custom'
        platform: 'google',
        // 广告位置：'header', 'sidebar', 'footer', 'content'
        positions: ['sidebar', 'footer'],
        // 广告 ID（根据平台填写）
        adId: 'ca-pub-xxxxxxxxxxxxxxxx', // Google AdSense
        // adId: 'cpro_xxxxxxxx', // 百度联盟
        // adId: 'xxxxxxxx', // 腾讯广告
    };

    // 如果广告未启用，直接返回
    if (!AD_CONFIG.enabled) {
        return;
    }

    /**
     * 创建 Google AdSense 广告
     */
    function createGoogleAd(containerId, adSlot, adFormat = 'auto') {
        const container = document.getElementById(containerId);
        if (!container) return;

        const adScript = document.createElement('script');
        adScript.async = true;
        adScript.src = `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=${AD_CONFIG.adId}`;
        adScript.crossOrigin = 'anonymous';
        document.head.appendChild(adScript);

        const adDiv = document.createElement('div');
        adDiv.className = 'adsbygoogle';
        adDiv.style.display = 'block';
        adDiv.setAttribute('data-ad-client', AD_CONFIG.adId);
        adDiv.setAttribute('data-ad-slot', adSlot);
        adDiv.setAttribute('data-ad-format', adFormat);
        adDiv.setAttribute('data-full-width-responsive', 'true');
        
        container.appendChild(adDiv);

        // 延迟加载广告，避免影响页面性能
        setTimeout(() => {
            try {
                (adsbygoogle = window.adsbygoogle || []).push({});
            } catch (e) {
                console.warn('AdSense 加载失败:', e);
            }
        }, 1000);
    }

    /**
     * 创建百度联盟广告
     */
    function createBaiduAd(containerId, adSlot) {
        const container = document.getElementById(containerId);
        if (!container) return;

        const adScript = document.createElement('script');
        adScript.src = `https://cpro.baidustatic.com/cpro/ui/c.js`;
        document.head.appendChild(adScript);

        const adDiv = document.createElement('div');
        adDiv.id = `cpro_${adSlot}`;
        adDiv.style.cssText = 'width:300px;height:250px;';
        container.appendChild(adDiv);

        setTimeout(() => {
            try {
                window.baidu_clb_fillSlot && window.baidu_clb_fillSlot(`cpro_${adSlot}`);
            } catch (e) {
                console.warn('百度联盟广告加载失败:', e);
            }
        }, 1000);
    }

    /**
     * 创建腾讯广告
     */
    function createTencentAd(containerId, adSlot) {
        const container = document.getElementById(containerId);
        if (!container) return;

        const adScript = document.createElement('script');
        adScript.src = 'https://qzs.qq.com/qzone/biz/res/i.js';
        document.head.appendChild(adScript);

        const adDiv = document.createElement('div');
        adDiv.id = `qzone_${adSlot}`;
        adDiv.style.cssText = 'width:300px;height:250px;';
        container.appendChild(adDiv);
    }

    /**
     * 创建自定义广告（可以放置任何 HTML）
     */
    function createCustomAd(containerId, html) {
        const container = document.getElementById(containerId);
        if (!container) return;

        container.innerHTML = html;
    }

    /**
     * 创建广告容器
     */
    function createAdContainer(position) {
        const containerId = `ad-container-${position}`;
        
        // 如果容器已存在，直接返回
        if (document.getElementById(containerId)) {
            return containerId;
        }

        const container = document.createElement('div');
        container.id = containerId;
        container.className = 'ad-container';

        // 根据位置插入到不同地方
        switch (position) {
            case 'sidebar':
                // 插入到侧边栏底部
                const sidebar = document.querySelector('.md-sidebar--secondary');
                if (sidebar) {
                    const sidebarInner = sidebar.querySelector('.md-sidebar__inner') || sidebar;
                    sidebarInner.appendChild(container);
                }
                break;
            
            case 'footer':
                // 插入到页脚之前
                const footer = document.querySelector('.md-footer');
                if (footer && footer.parentNode) {
                    footer.parentNode.insertBefore(container, footer);
                }
                break;
            
            case 'content':
                // 插入到内容区域
                const content = document.querySelector('.md-content__inner');
                if (content) {
                    // 在第一个 h2 之后插入
                    const firstH2 = content.querySelector('h2');
                    if (firstH2 && firstH2.nextSibling) {
                        firstH2.parentNode.insertBefore(container, firstH2.nextSibling);
                    } else {
                        content.insertBefore(container, content.firstChild);
                    }
                }
                break;
            
            case 'header':
                // 插入到头部导航之后
                const header = document.querySelector('.md-header');
                if (header && header.nextSibling) {
                    header.parentNode.insertBefore(container, header.nextSibling);
                }
                break;
        }

        return containerId;
    }

    /**
     * 初始化广告
     */
    function initAds() {
        // 等待页面加载完成
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initAds);
            return;
        }

        // 延迟加载，避免影响首屏渲染
        setTimeout(() => {
            AD_CONFIG.positions.forEach((position, index) => {
                // 创建广告容器
                const containerId = createAdContainer(position);
                const adSlot = `${AD_CONFIG.platform}-${position}-${index}`;

                switch (AD_CONFIG.platform) {
                    case 'google':
                        createGoogleAd(containerId, adSlot);
                        break;
                    case 'baidu':
                        createBaiduAd(containerId, adSlot);
                        break;
                    case 'tencent':
                        createTencentAd(containerId, adSlot);
                        break;
                    case 'custom':
                        // 自定义广告 HTML
                        createCustomAd(containerId, `
                            <div style="padding: 10px; background: #f5f5f5; border-radius: 4px; text-align: center;">
                                <p style="margin: 0; color: #666;">广告位</p>
                                <p style="margin: 5px 0 0 0; font-size: 12px; color: #999;">300x250</p>
                            </div>
                        `);
                        break;
                }
            });
        }, 2000); // 延迟 2 秒加载广告
    }

    // 开始初始化
    initAds();
})();

