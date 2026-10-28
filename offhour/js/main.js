/**
 * OFF HOUR v3 (Retro Pop) — interactions (no external libraries)
 * - Header state on scroll
 * - Scroll reveal via IntersectionObserver (USP 수치 순차 등장 포함)
 * - Subtle parallax for product images (rAF)
 * - Respects prefers-reduced-motion
 */
(() => {
  'use strict';

  const reduce = window.matchMedia('(prefers-reduced-motion: reduce)');
  const header = document.querySelector('[data-header]');

  /* Hero: click a can to bring it to the center/front */
  const stage = document.querySelector('[data-can-stage]');
  if (stage) {
    const names = { g: '자몽피즈', l: '라임브리즈', p: '피치플러셔' };
    const status = stage.querySelector('[data-can-status]');
    const cans = [...stage.querySelectorAll('[data-can]')];

    stage.addEventListener('click', (e) => {
      const picked = e.target.closest('[data-can]');
      if (!picked || picked.dataset.pos === 'center') return;
      const current = cans.find((c) => c.dataset.pos === 'center');
      current.dataset.pos = picked.dataset.pos; // 기존 가운데 캔은 빈 자리로
      picked.dataset.pos = 'center';
      cans.forEach((c) => c.setAttribute('aria-pressed', String(c === picked)));
      const hero = stage.closest('.hero');
      if (hero) hero.dataset.theme = picked.dataset.can; // 배경 테마 전환
      if (status) status.textContent = `${names[picked.dataset.can]}가 가운데에 있습니다.`;
    });
  }

  /* Scroll reveal */
  const targets = document.querySelectorAll('[data-reveal]');
  if ('IntersectionObserver' in window && !reduce.matches) {
    const io = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        entry.target.classList.add('is-visible');
        io.unobserve(entry.target);
      });
    }, { rootMargin: '0px 0px -10% 0px', threshold: 0.12 });
    targets.forEach((el) => io.observe(el));
  } else {
    targets.forEach((el) => el.classList.add('is-visible'));
  }

  /* Parallax */
  const layers = [...document.querySelectorAll('[data-parallax]')];
  let ticking = false;

  const update = () => {
    const vh = window.innerHeight;
    layers.forEach((el) => {
      const r = el.getBoundingClientRect();
      if (r.bottom < -200 || r.top > vh + 200) return;
      const speed = parseFloat(el.dataset.parallax) || 0;
      const y = (r.top + r.height / 2 - vh / 2) * -speed;
      el.style.translate = `0 ${y.toFixed(1)}px`;
    });
    ticking = false;
  };

  const onScroll = () => {
    header?.classList.toggle('is-scrolled', window.scrollY > 24);
    if (reduce.matches || ticking) return;
    ticking = true;
    requestAnimationFrame(update);
  };

  window.addEventListener('scroll', onScroll, { passive: true });
  window.addEventListener('resize', onScroll, { passive: true });
  reduce.addEventListener('change', () => {
    if (reduce.matches) layers.forEach((el) => { el.style.translate = ''; });
  });
  onScroll();
})();
