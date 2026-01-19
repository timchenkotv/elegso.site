#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

TS="$(date +%Y-%m-%d_%H-%M-%S)"
cp -a src/components/CasesSection.astro "src/components/CasesSection.astro.bak.${TS}"

cat > src/components/CasesSection.astro <<'ASTRO'
---
const themes = [
  {
    id: "leasing-penalty",
    title: "Лизинг: возврат и уменьшение неустойки",
    lead:
      "В пользу лизингополучателя взыскали излишне удержанную неустойку и добились снижения требований лизингодателя по пеням и санкциям.",
    cases: [
      {
        id: "a40-117474-2023",
        title:
          "А40-117474/23-182-653: возврат 4,75 млн ₽ и отказ от 4,03 млн ₽ встречных требований",
        teaser:
          "Лизингодатель годами списывал неустойку внутри платежей и попытался заблокировать выкуп. Дожали до кассации — и развернули спор в пользу бизнеса.",
        stats: {
          court: "АС г. Москвы",
          duration: "≈ 2 года · 12 заседаний",
          recovered: "4 750 000 ₽",
          removed: "4 027 766,99 ₽",
          claim: "10 817 373,68 ₽",
        },
        pdfs: [
          {
            id: "settlement-2025",
            label: "Мировое (определение)",
            date: "21.04.2025",
            file: "/cases/A40-117474-2023_20250421_Opredelenie.pdf",
          },
          {
            id: "cassation-2024",
            label: "Кассация",
            date: "03.12.2024",
            file: "/cases/A40-117474-2023_20241203_Reshenija_i_postanovlenija.pdf",
          },
          {
            id: "appeal-2024",
            label: "Апелляция",
            date: "19.08.2024",
            file: "/cases/A40-117474-2023_20240819_Postanovlenie_apelljacionnoj_instancii.pdf",
          },
          {
            id: "first-2024",
            label: "Первая инстанция",
            date: "06.05.2024",
            file: "/cases/A40-117474-2023_20240503_Reshenija_i_postanovlenija.pdf",
          },
        ],
        detailsHref: "/cases/a40-117474-2023",
        storyShort: `
Это дело началось спокойно — выкупной лизинг, техника в работе, платежи идут. Потом у клиента наступил тяжелый период: платежи стали поступать с просрочкой, но договор сохранялся — лизингодатель принимал исполнение и не расторгал отношения.

Параллельно возникла «скрытая механика»: вместо судебного взыскания лизингодатель стал списывать неустойку внутри поступающих платежей. Когда подошёл момент выкупа, бизнесу предъявили новые требования и фактически попытались удержать имущество до оплаты «дополнительной» неустойки.

Наша команда сделала экономико-правовой анализ и доказала: в этих правоотношениях неустойка утратила стимулирующую функцию и стала инструментом обогащения — значит требуется судебный контроль соразмерности (ст. 333 ГК РФ) и возврат излишне удержанного. Две инстанции заняли формальный подход, но в кассации судебные акты были отменены, что изменило переговорную позицию сторон. Итог — мировое: отказ от встречных требований и возврат 4,75 млн ₽.
        `.trim(),
      },
    ],
  },
];
---

<section id="cases" class="mx-auto max-w-6xl px-6 py-14">
  <div class="grid gap-8">
    <header>
      <h2 class="text-xl font-semibold text-slate-50">Кейсы (наши успешно выполненные юридические проекты)</h2>
      <p class="mt-2 max-w-3xl text-sm text-slate-400">
        Здесь — реальные судебные истории (без раскрытия конфиденциальных деталей): задача → стратегия → процесс → результат.
        Мы показываем не «обещания», а доказуемую логику и цифры.
      </p>
    </header>

    <div class="grid gap-4">
      {themes.map((t) => (
        <details class="rounded-3xl border border-slate-800 bg-slate-900/20 p-5">
          <summary class="cursor-pointer list-none">
            <div class="flex items-start justify-between gap-4">
              <div>
                <div class="text-sm font-semibold text-slate-50">{t.title}</div>
                <div class="mt-1 text-sm text-slate-400">{t.lead}</div>
              </div>
              <span class="mt-0.5 inline-flex h-8 w-8 items-center justify-center rounded-full border border-slate-700 bg-slate-950/40 text-slate-200">
                <span aria-hidden="true">⌄</span>
              </span>
            </div>
          </summary>

          <div class="mt-5 grid gap-3">
            {t.cases.map((c) => (
              <details class="rounded-2xl border border-slate-800 bg-slate-950/30 p-4">
                <summary class="cursor-pointer list-none">
                  <div class="flex items-start justify-between gap-4">
                    <div>
                      <div class="text-sm font-semibold text-slate-50">{c.title}</div>
                      <div class="mt-1 text-sm text-slate-400">{c.teaser}</div>
                    </div>
                    <span class="mt-0.5 inline-flex h-8 w-8 items-center justify-center rounded-full border border-slate-700 bg-slate-950/40 text-slate-200">
                      <span aria-hidden="true">⌄</span>
                    </span>
                  </div>
                </summary>

                <div class="mt-4 grid gap-4 lg:grid-cols-[1fr_1fr] lg:items-start">
                  <div class="grid gap-3">
                    <div class="rounded-2xl border border-slate-800 bg-slate-900/20 p-4">
                      <div class="text-xs font-semibold text-slate-200">Сводка по делу</div>
                      <div class="mt-3 grid gap-2 text-sm text-slate-300">
                        <div class="flex justify-between gap-3"><span class="text-slate-400">Суд</span><span>{c.stats.court}</span></div>
                        <div class="flex justify-between gap-3"><span class="text-slate-400">Длительность</span><span>{c.stats.duration}</span></div>
                        <div class="flex justify-between gap-3"><span class="text-slate-400">Взыскано</span><span class="text-amber-200">{c.stats.recovered}</span></div>
                        <div class="flex justify-between gap-3"><span class="text-slate-400">Снято требований</span><span class="text-amber-200">{c.stats.removed}</span></div>
                        <div class="flex justify-between gap-3"><span class="text-slate-400">Цена иска</span><span>{c.stats.claim}</span></div>
                      </div>
                    </div>

                    <div class="rounded-2xl border border-slate-800 bg-slate-900/20 p-4">
                      <div class="text-xs font-semibold text-slate-200">Короткая история (чтобы было ясно без перехода)</div>
                      <p class="mt-2 whitespace-pre-line text-sm leading-relaxed text-slate-300">{c.storyShort}</p>

                      <div class="mt-4 flex flex-wrap gap-2">
                        <a
                          href={c.detailsHref}
                          class="inline-flex items-center justify-center rounded-xl bg-amber-400 px-4 py-2 text-sm font-semibold text-slate-950 hover:brightness-110"
                        >
                          Читать ход процесса подробно
                        </a>
                        <a
                          href="#contacts"
                          class="inline-flex items-center justify-center rounded-xl border border-slate-700 bg-slate-950/40 px-4 py-2 text-sm font-semibold text-slate-100 hover:bg-slate-950/70"
                        >
                          Обсудить похожую ситуацию
                        </a>
                      </div>

                      <div class="mt-3 text-xs text-slate-500">
                        PDF-материалы справа: выберите документ в ленте сверху, откройте или скачайте.
                      </div>
                    </div>
                  </div>

                  <div class="rounded-2xl border border-slate-800 bg-slate-900/20 p-4">
                    <div class="text-xs font-semibold text-slate-200">Материалы по делу (PDF)</div>

                    <div class="mt-3 flex gap-2 overflow-auto pb-1">
                      {c.pdfs.map((p, idx) => (
                        <button
                          class={"case-pdf-tab inline-flex min-w-[170px] flex-col gap-1 rounded-xl border border-slate-800 bg-slate-950/40 px-3 py-2 text-left hover:bg-slate-950/70"}
                          type="button"
                          data-case={c.id}
                          data-pdf={p.id}
                          data-file={p.file}
                          data-label={p.label}
                          aria-current={idx === 0 ? "true" : "false"}
                        >
                          <span class="text-xs font-semibold text-slate-100">{p.label}</span>
                          <span class="text-[11px] text-slate-400">{p.date}</span>
                        </button>
                      ))}
                    </div>

                    <div class="mt-3 grid gap-2">
                      <div class="flex flex-wrap items-center justify-between gap-2">
                        <div class="text-sm font-semibold text-slate-50" data-pdf-title={c.id}>{c.pdfs[0].label}</div>

                        <div class="flex gap-2">
                          <a
                            class="inline-flex items-center justify-center rounded-lg border border-slate-700 bg-slate-950/40 px-3 py-1.5 text-xs font-semibold text-slate-100 hover:bg-slate-950/70"
                            data-pdf-open={c.id}
                            href={c.pdfs[0].file}
                            target="_blank"
                            rel="noreferrer"
                          >
                            Открыть
                          </a>
                          <a
                            class="inline-flex items-center justify-center rounded-lg border border-slate-700 bg-slate-950/40 px-3 py-1.5 text-xs font-semibold text-slate-100 hover:bg-slate-950/70"
                            data-pdf-download={c.id}
                            href={c.pdfs[0].file}
                            download
                          >
                            Скачать
                          </a>
                        </div>
                      </div>

                      <div class="rounded-2xl border border-slate-800 bg-slate-950/30">
                        <iframe
                          data-pdf-frame={c.id}
                          class="h-[520px] w-full rounded-2xl"
                          src={`${c.pdfs[0].file}#page=1&toolbar=0&navpanes=0`}
                          title={`PDF: ${c.pdfs[0].label}`}
                        />
                      </div>

                      <div class="text-[11px] text-slate-500">
                        Подсказка: прокручивайте PDF внутри окна. «Открыть» — полный просмотр в новой вкладке.
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
        const tabs = document.querySelectorAll(".case-pdf-tab");
        tabs.forEach((btn) => {
          btn.addEventListener("click", () => {
            const caseId = btn.getAttribute("data-case");
            const file = btn.getAttribute("data-file");
            const label = btn.getAttribute("data-label");
            if (!caseId || !file || !label) return;

            document
              .querySelectorAll(\`.case-pdf-tab[data-case="\${caseId}"]\`)
              .forEach((b) => b.setAttribute("aria-current", "false"));
            btn.setAttribute("aria-current", "true");

            const t = document.querySelector(\`[data-pdf-title="\${caseId}"]\`);
            if (t) t.textContent = label;

            const frame = document.querySelector(\`[data-pdf-frame="\${caseId}"]\`);
            if (frame) frame.setAttribute("src", \`\${file}#page=1&toolbar=0&navpanes=0\`);

            const open = document.querySelector(\`[data-pdf-open="\${caseId}"]\`);
            if (open) open.setAttribute("href", file);

            const dl = document.querySelector(\`[data-pdf-download="\${caseId}"]\`);
            if (dl) dl.setAttribute("href", file);
          });
        });
      };

      if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", init);
      } else {
        init();
      }
    })();
  </script>

  <style is:inline>
    summary::-webkit-details-marker { display: none; }
    .case-pdf-tab[aria-current="true"] {
      border-color: rgba(251, 191, 36, .45);
      background: rgba(251, 191, 36, .06);
    }
  </style>
</section>
ASTRO

echo "OK: script prepared"
ls -la tools/patch_cases_section.sh
