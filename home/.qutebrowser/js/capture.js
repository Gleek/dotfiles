(() => {
  let selected = encodeURIComponent(window.getSelection());
  let url = encodeURIComponent(location.href);
  let title = encodeURIComponent(document.title);
  let href = "org-protocol://capture?template=c";
  if (url) {
    href += "&url=" + url;
  }
  if (title) {
    href += "&title=" + title;
  }
  if (selected) {
    href += "&body=" + selected;
  }
  location.href = href;
})();
