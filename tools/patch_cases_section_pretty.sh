#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

TARGET="src/components/CasesSection.astro"
BACKUP="$TARGET.bak.pretty.$(date +%Y-%m-%d_%H-%M-%S)"
cp -a "$TARGET" "$BACKUP"

cat > "$TARGET" <<'ASTRO'
---
const themes = [
  {
    id: "leasing-penalty",
    title: "Лизинг: возврат и уменьшение неустойки",
    lead:
      "В пользу лизингополучателя взыскали излишне удержанную неустойку; уменьшили размер санкций и требований лизингодателя. Защитили экономику выкупного лизинга: неустойка не может превращаться в скрытую цену договора.",
    cases: [
      {
        id: "a40-117474-2023",
        caseNo: "А40-117474/2023",
        caseFull: "А40-117474/23-182-653",
        court: "Арбитражный суд г. Москвы",
        judge: "Моисеева Ю.Б.",
        duration: "≈ 2 года · 12 заседаний",
        recovered: "4 750 000 ₽",
        removed: "4 027 766,99 ₽",
        claim: "10 817 373,68 ₽",
        title:
          "Возврат 4,75 млн ₽ и отказ лизингодателя от 4,03 млн ₽ встречных требований",
        teaser:
          "Лизингодатель списывал неустойку внутри платежей и попытался удержать выкуп. Мы довели спор до кассации — и развернули ситуацию в пользу бизнеса.",
        story:
`Это дело началось спокойно: выкупной лизинг, техника в работе, платежи идут. Затем у лизингополучателя наступил тяжелый период — платежи стали поступать с просрочкой, но договор сохранялся: лизингодатель принимал исполнение и не расторгал отношения.

Параллельно появилась «скрытая механика»: вместо судебного взыскания лизингодатель стал списывать неустойку внутри поступающих платежей, лишая возможности уменьшить её по статье 333 ГК РФ через суд. Когда подошёл момент выкупа, бизнесу предъявили новые требования и фактически попытались удержать имущество до оплаты «дополнительной» неустойки.

Мы доказали: в таких правоотношениях неустойка утрачивает стимулирующую функцию и превращается в способ обогащения — значит нужен судебный контроль соразмерности (ст. 333 ГК РФ), проверка реальных последствий и возврат излишне удержанного. Две инстанции заняли формальный подход, но кассация отменила акты и вернула дело на новое рассмотрение. Итог — мировое: отказ от встречных требований и возврат 4,75 млн ₽.`,
        pdfs: [
          { id: "p4", label: "Мировое (определение)", date: "21.04.2025", file: "/cases/A40-117474-2023_20250421_Opredelenie.pdf" },
          { id: "p3", label: "Кассация", date: "03.12.2024", file: "/cases/A40-117474-2023_20241203_Reshenija_i_postanovlenija.pdf" },
          { id: "p2", label: "Апелляция", date: "19.08.2024", file: "/cases/A40-117474-2023_20240819_Postanovlenie_apelljacionnoj_instancii.pdf" },
          { id: "p1", label: "Первая инстанция", date: "06.05.2024", file: "/cases/A40-117474-2023_20240503_Reshenija_i_postanovlenija.pdf" },
        ],
        detailsHref: "/cases/a40-117474-2023",
      },
    ],
  },
];
---

<section class="section casesx" id="cases">
  <div class="container">
    <h3>Кейсы (наши успешно выполненные юридические проекты)</h3>
    <p class="casesx-muted">
      Здесь — реальные судебные истории (без раскрытия конфиденциальных деталей): задача → стратегия → процесс → результат.
      Мы показываем не «обещания», а доказуемую логику и цифры.
    </p>

    <div class="casesx-stack">
      {themes.map((t) => (
        <details class="casesx-acc">
          <summary class="casesx-sum">
            <div class="casesx-sumL">
              <div class="casesx-h">{t.title}</div>
              <div class="casesx-sub">{t.lead}</div>
            </div>
            <span class="casesx-chev" aria-hidden="true"></span>
          </summary>

          <div class="casesx-body">
            {t.cases.map((c) => (
              <details class="casesx-acc">
                <summary class="casesx-sum">
                  <div class="casesx-sumL">
                    <div class="casesx-h">{c.caseFull} — {c.title}</div>
                    <div class="casesx-sub">{c.teaser}</div>
                  </div>
                  <span class="casesx-chev" aria-hidden="true"></span>
                </summary>

                <div class="casesx-body">
                  <div class="casesx-shell">

                    <div class="casesx-strip" role="tablist" aria-label="PDF материалы по делу">
                      {c.pdfs.map((p, idx) => (
                        <button
                          class={"casesx-tab" + (idx === 0 ? " active" : "")}
                          type="button"
                          data-pdf-tab
                          data-case={c.id}
                          data-file={p.file}
                          data-label={p.label}
                        >
                          <div class="h">{p.label}</div>
                          <div class="d">{p.date}</div>
                        </button>
                      ))}
                    </div>

                    <div class="casesx-grid">
                      <div class="casesx-left">
                        <div class="casesx-card">
                          <div class="casesx-cap">Сводные данные</div>
                          <div class="casesx-kv">
                            <div><span>Дело</span><b>{c.caseNo}</b></div>
                            <div><span>Суд</span><b>{c.court}</b></div>
                            <div><span>Судья</span><b>{c.judge}</b></div>
                            <div><span>Длительность</span><b>{c.duration}</b></div>
                            <div><span>Взыскано</span><b class="accent">{c.recovered}</b></div>
                            <div><span>Снято требований</span><b class="accent">{c.removed}</b></div>
                            <div><span>Цена иска</span><b>{c.claim}</b></div>
                          </div>
                        </div>

                        <div class="casesx-card">
                          <div class="casesx-cap">Короткая история</div>
                          <div class="casesx-story">{c.story}</div>

                          <div class="casesx-actions">
                            <a class="casesx-btn primary" href={c.detailsHref}>Читать ход процесса подробно</a>
                            <a class="casesx-btn" href="#contacts">Обсудить похожую ситуацию</a>
                          </div>

                          <div class="casesx-fine">
                            Справа — материалы по делу. Выберите документ в ленте, откройте в новой вкладке или скачайте.
                          </div>
                        </div>
                      </div>

                      <div class="casesx-right">
                        <div class="casesx-top">
                          <b data-pdf-title={c.id}>{c.pdfs[0].label}</b>
                          <div class="casesx-topBtns">
                            <a class="casesx-btn" data-pdf-open={c.id} href={c.pdfs[0].file} target="_blank" rel="noreferrer">Открыть</a>
                            <a class="casesx-btn" data-pdf-download={c.id} href={c.pdfs[0].file} download>Скачать</a>
                          </div>
                        </div>

                        <div class="casesx-pdf">
                          <iframe
                            data-pdf-frame={c.id}
                            src={`${c.pdfs[0].file}#page=1&toolbar=0&navpanes=0`}
                            title={`PDF: ${c.pdfs[0].label}`}
                            loading="lazy"
                          />
                        </div>

                        <div class="casesx-fine">
                          PDF можно прокручивать и читать прямо здесь. Для полного просмотра нажмите «Открыть».
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </details>
            ))}
          </div>
        </details>
      ))}
    </div>
  </div>

  <script is:inline>
    (() => {
      const init = () => {
        document.querySelectorAll("[data-pdf-tab]").forEach((btn) => {
          btn.addEventListener("click", () => {
            const caseId = btn.getAttribute("data-case");
            const file = btn.getAttribute("data-file");
            const label = btn.getAttribute("data-label");
            if (!caseId || !file || !label) return;

            document
              .querySelectorAll("[data-pdf-tab][data-case=\\"" + caseId + "\\"]")
              .forEach((b) => b.classList.remove("active"));
            btn.classList.add("active");

            const t = document.querySelector("[data-pdf-title=\\"" + caseId + "\\"]");
            if (t) t.textContent = label;

            const frame = document.querySelector("[data-pdf-frame=\\"" + caseId + "\\"]");
            if (frame) frame.setAttribute("src", file + "#page=1&toolbar=0&navpanes=0");

            const open = document.querySelector("[data-pdf-open=\\"" + caseId + "\\"]");
            if (open) open.setAttribute("href", file);

            const dl = document.querySelector("[data-pdf-download=\\"" + caseId + "\\"]");
            if (dl) dl.setAttribute("href", file);
          });
        });
      };

      if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
      else init();
    })();
  </script>
  <style is:inline>
    /* Свой стиль, но на переменных сайта: выглядит "родным" независимо от data-astro-cid */
    .casesx { padding: 34px 0; }
    .casesx-muted { margin: 0; color: var(--muted); max-width: 92ch; }

    .casesx-stack { margin-top: 14px; display: grid; gap: 12px; }
    .casesx-acc { border: 1px solid rgba(232,238,252,.1); border-radius: 18px; background: #0b122059; overflow: hidden; }

    .casesx-sum { cursor: pointer; list-style: none; display: grid; grid-template-columns: 1fr auto; gap: 6px 12px; align-items: center; padding: 14px 16px; user-select: none; }
    .casesx-sum::-webkit-details-marker { display:none; }

    .casesx-h { font-weight: 750; color: #e8eefcf2; }
    .casesx-sub { margin-top: 6px; color: #b7c3ddd9; font-size: 12px; line-height: 1.35; }

    .casesx-chev { width:10px; height:10px; border-right:2px solid rgba(232,238,252,.65); border-bottom:2px solid rgba(232,238,252,.65); transform: rotate(45deg); transition: transform .2s ease, opacity .2s ease; opacity:.85; justify-self:end; }
    details[open] > .casesx-sum .casesx-chev { transform: rotate(225deg); }

    .casesx-body { border-top: 1px solid rgba(232,238,252,.08); padding: 14px 16px 16px; background: #070b1459; }

    .casesx-shell { border:1px solid var(--line); border-radius: 22px; background: linear-gradient(180deg,#0b122080,#070b1459); box-shadow: 0 18px 50px #00000047; padding: 14px; overflow:hidden; }

    .casesx-strip { display:flex; gap:10px; align-items:center; overflow:auto; padding-bottom:6px; margin-bottom:12px; }
    .casesx-strip::-webkit-scrollbar{ height:8px; }
    .casesx-strip::-webkit-scrollbar-thumb{ background:#e8eefc1f; border-radius:10px; }

    .casesx-tab { flex:0 0 auto; width:220px; border-radius:16px; border:1px solid rgba(232,238,252,.14); background:#0b12208c; padding:10px 12px; cursor:pointer; text-align:left; transition: transform .16s ease,border-color .16s ease,box-shadow .16s ease; }
    .casesx-tab:hover { transform: translateY(-1px); border-color:#7fd3ff59; box-shadow:0 10px 24px #00000038; }
    .casesx-tab.active { border-color:#c6a15a8c; box-shadow:0 0 0 1px #c6a15a40,0 14px 34px #0000004d; }
    .casesx-tab .h { font-size:12px; font-weight:700; color:#e8eefcf2; }
    .casesx-tab .d { font-size:12px; color:#b7c3ddbf; margin-top:6px; }

    .casesx-grid { display:grid; grid-template-columns: 1.05fr .95fr; gap: 14px; align-items: stretch; }
    @media(max-width:980px){ .casesx-grid{ grid-template-columns: 1fr; } }

    .casesx-left { display:grid; gap: 12px; }

    .casesx-card { border: 1px solid rgba(232,238,252,.12); background: linear-gradient(180deg,#0f1a30bf,#0e16288c); border-radius: var(--radius2); box-shadow: 0 18px 50px #00000059; padding: 14px; position:relative; overflow:hidden; }
    .casesx-card:before{ content:""; position:absolute; inset:-40%; background: radial-gradient(closest-side at 30% 30%,rgba(127,211,255,.14),transparent 60%), radial-gradient(closest-side at 70% 40%,rgba(198,161,90,.16),transparent 58%); transform: rotate(10deg); pointer-events:none; }
    .casesx-card > * { position: relative; }

    .casesx-cap { font-size: 12px; letter-spacing: .06em; text-transform: uppercase; color: #e8eefcd9; }
    .casesx-kv { margin-top: 10px; display:grid; gap: 8px; }
    .casesx-kv > div { display:flex; justify-content: space-between; gap:10px; }
    .casesx-kv span { color:#b7c3ddbf; font-size:12px; }
    .casesx-kv b { color:#e8eefcf2; font-weight: 750; }
    .casesx-kv b.accent { color: var(--accent); }

    .casesx-story { margin-top: 10px; color:#b7c3ddeb; line-height:1.45; white-space: pre-line; }
    .casesx-actions { margin-top: 12px; display:flex; gap:10px; flex-wrap:wrap; }
    .casesx-fine { margin-top: 10px; color:#b7c3ddbf; font-size:12px; }

    .casesx-right { display:grid; gap:10px; }
    .casesx-top { display:flex; justify-content: space-between; gap:10px; align-items:center; flex-wrap:wrap; }
    .casesx-topBtns { display:flex; gap:10px; flex-wrap:wrap; }

    .casesx-pdf { border:1px solid rgba(232,238,252,.12); border-radius:22px; overflow:hidden; background:#0b122073; height:520px; }
    .casesx-pdf iframe { width:100%; height:100%; border:0; display:block; }

    .casesx-btn { padding:10px 14px; border-radius:14px; border:1px solid rgba(198,161,90,.35); background:#c6a15a1a; color: var(--text); cursor:pointer; font:inherit; display:inline-flex; align-items:center; gap:10px; white-space:nowrap; }
    .casesx-btn:hover { background:#c6a15a24; border-color:#c6a15a8c; transform: translateY(-1px); }
    .casesx-btn.primary { border-color:#c6a15a99; background: linear-gradient(135deg,#c6a15af2,#7fd3ff40); color:#0b1220f2; font-weight:650; }
  </style>
</section>
  <style is:inline>
    /* Свой стиль, но на переменных сайта: выглядит "родным" независимо от data-astro-cid */
    .casesx { padding: 34px 0; }
    .casesx-muted { margin: 0; color: var(--muted); max-width: 92ch; }

    .casesx-stack { margin-top: 14px; display: grid; gap: 12px; }
    .casesx-acc { border: 1px solid rgba(232,238,252,.1); border-radius: 18px; background: #0b122059; overflow: hidden; }

    .casesx-sum { cursor: pointer; list-style: none; display: grid; grid-template-columns: 1fr auto; gap: 6px 12px; align-items: center; padding: 14px 16px; user-select: none; }
    .casesx-sum::-webkit-details-marker { display:none; }

    .casesx-h { font-weight: 750; color: #e8eefcf2; }
    .casesx-sub { margin-top: 6px; color: #b7c3ddd9; font-size: 12px; line-height: 1.35; }

    .casesx-chev { width:10px; height:10px; border-right:2px solid rgba(232,238,252,.65); border-bottom:2px solid rgba(232,238,252,.65); transform: rotate(45deg); transition: transform .2s ease, opacity .2s ease; opacity:.85; justify-self:end; }
    details[open] > .casesx-sum .casesx-chev { transform: rotate(225deg); }

    .casesx-body { border-top: 1px solid rgba(232,238,252,.08); padding: 14px 16px 16px; background: #070b1459; }

    .casesx-shell { border:1px solid var(--line); border-radius: 22px; background: linear-gradient(180deg,#0b122080,#070b1459); box-shadow: 0 18px 50px #00000047; padding: 14px; overflow:hidden; }

    .casesx-strip { display:flex; gap:10px; align-items:center; overflow:auto; padding-bottom:6px; margin-bottom:12px; }
    .casesx-strip::-webkit-scrollbar{ height:8px; }
    .casesx-strip::-webkit-scrollbar-thumb{ background:#e8eefc1f; border-radius:10px; }

    .casesx-tab { flex:0 0 auto; width:220px; border-radius:16px; border:1px solid rgba(232,238,252,.14); background:#0b12208c; padding:10px 12px; cursor:pointer; text-align:left; transition: transform .16s ease,border-color .16s ease,box-shadow .16s ease; }
    .casesx-tab:hover { transform: translateY(-1px); border-color:#7fd3ff59; box-shadow:0 10px 24px #00000038; }
    .casesx-tab.active { border-color:#c6a15a8c; box-shadow:0 0 0 1px #c6a15a40,0 14px 34px #0000004d; }
    .casesx-tab .h { font-size:12px; font-weight:700; color:#e8eefcf2; }
    .casesx-tab .d { font-size:12px; color:#b7c3ddbf; margin-top:6px; }

    .casesx-grid { display:grid; grid-template-columns: 1.05fr .95fr; gap: 14px; align-items: stretch; }
    @media(max-width:980px){ .casesx-grid{ grid-template-columns: 1fr; } }

    .casesx-left { display:grid; gap: 12px; }

    .casesx-card { border: 1px solid rgba(232,238,252,.12); background: linear-gradient(180deg,#0f1a30bf,#0e16288c); border-radius: var(--radius2); box-shadow: 0 18px 50px #00000059; padding: 14px; position:relative; overflow:hidden; }
    .casesx-card:before{ content:""; position:absolute; inset:-40%; background: radial-gradient(closest-side at 30% 30%,rgba(127,211,255,.14),transparent 60%), radial-gradient(closest-side at 70% 40%,rgba(198,161,90,.16),transparent 58%); transform: rotate(10deg); pointer-events:none; }
    .casesx-card > * { position: relative; }

    .casesx-cap { font-size: 12px; letter-spacing: .06em; text-transform: uppercase; color: #e8eefcd9; }
    .casesx-kv { margin-top: 10px; display:grid; gap: 8px; }
    .casesx-kv > div { display:flex; justify-content: space-between; gap:10px; }
    .casesx-kv span { color:#b7c3ddbf; font-size:12px; }
    .casesx-kv b { color:#e8eefcf2; font-weight: 750; }
    .casesx-kv b.accent { color: var(--accent); }

    .casesx-story { margin-top: 10px; color:#b7c3ddeb; line-height:1.45; white-space: pre-line; }
    .casesx-actions { margin-top: 12px; display:flex; gap:10px; flex-wrap:wrap; }
    .casesx-fine { margin-top: 10px; color:#b7c3ddbf; font-size:12px; }

    .casesx-right { display:grid; gap:10px; }
    .casesx-top { display:flex; justify-content: space-between; gap:10px; align-items:center; flex-wrap:wrap; }
    .casesx-topBtns { display:flex; gap:10px; flex-wrap:wrap; }

    .casesx-pdf { border:1px solid rgba(232,238,252,.12); border-radius:22px; overflow:hidden; background:#0b122073; height:520px; }
    .casesx-pdf iframe { width:100%; height:100%; border:0; display:block; }

    .casesx-btn { padding:10px 14px; border-radius:14px; border:1px solid rgba(198,161,90,.35); background:#c6a15a1a; color: var(--text); cursor:pointer; font:inherit; display:inline-flex; align-items:center; gap:10px; white-space:nowrap; }
    .casesx-btn:hover { background:#c6a15a24; border-color:#c6a15a8c; transform: translateY(-1px); }
    .casesx-btn.primary { border-color:#c6a15a99; background: linear-gradient(135deg,#c6a15af2,#7fd3ff40); color:#0b1220f2; font-weight:650; }
  </style>
</section>
ASTRO

echo "OK: pretty CasesSection prepared"
SH
