//= link fontawesome-webfont.woff
//= link fontawesome-webfont.woff2

document.addEventListener('DOMContentLoaded', function activateBurgers () {
  var burgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0)
  if (!burgers.length) return
  burgers.forEach(function (el) {
    el.addEventListener('click', function (e) {
      e.stopPropagation()
      el.classList.toggle('is-active')
      document.getElementById(el.dataset.target).classList.toggle('is-active')
      //document.documentElement.classList.toggle('is-clipped')
    })
  })
  document.removeEventListener('DOMContentLoaded', activateBurgers)
})
