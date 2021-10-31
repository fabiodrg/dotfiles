// general
user_pref("browser.toolbars.bookmarks.visibility", "never");
user_pref("devtools.cache.disabled", true);
user_pref("devtools.theme", "dark");

// security and performance concerns
// https://www.reddit.com/r/firefox/comments/p8g5zd/why_does_disabling_accessibility_services_improve/
user_pref("accessibility.force_disabled", 1);

// video acceleration
// https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration
user_pref("gfx.webrender.all", true);
user_pref("gfx.x11-egl.force-enabled", true);
user_pref("gfx.x11-egl.force-disabled", false);
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffvpx.enabled", false);
user_pref("media.navigator.mediadatadecoder_vpx_enabled", true);
user_pref("media.rdd-process.enabled", false);

// privacy
user_pref("network.captive-portal-service.enabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.pioneer-new-studies-available", false);

// disable pocket
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);
