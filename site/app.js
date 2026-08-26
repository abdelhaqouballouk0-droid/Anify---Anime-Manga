(function () {
  var topbar = document.getElementById("topbar");
  if (topbar) {
    window.addEventListener("scroll", function () {
      topbar.classList.toggle("scrolled", window.scrollY > 4);
    }, { passive: true });
  }

  var copyBtn = document.getElementById("copy-email-btn");
  var toast = document.getElementById("toast");
  var toastTimer = null;

  function showToast(message) {
    if (!toast) return;
    toast.textContent = message;
    toast.classList.add("show");
    clearTimeout(toastTimer);
    toastTimer = setTimeout(function () {
      toast.classList.remove("show");
    }, 2200);
  }

  function fallbackCopy(text) {
    var ta = document.createElement("textarea");
    ta.value = text;
    ta.style.position = "fixed";
    ta.style.opacity = "0";
    document.body.appendChild(ta);
    ta.focus();
    ta.select();
    var ok = false;
    try { ok = document.execCommand("copy"); } catch (e) { ok = false; }
    document.body.removeChild(ta);
    return ok;
  }

  if (copyBtn) {
    copyBtn.addEventListener("click", function () {
      var email = copyBtn.getAttribute("data-email");
      var done = function (ok) {
        if (ok) {
          copyBtn.classList.add("copied");
          showToast("Email copied to clipboard");
          setTimeout(function () { copyBtn.classList.remove("copied"); }, 1600);
        } else {
          showToast("Couldn't copy — use the button above");
        }
      };
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(email).then(function () { done(true); }, function () { done(fallbackCopy(email)); });
      } else {
        done(fallbackCopy(email));
      }
    });
  }
})();
