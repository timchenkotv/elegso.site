#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

TARGET="src/components/CasesSection.astro"
BACKUP="$TARGET.bak.$(date +%Y-%m-%d_%H-%M-%S)"
cp -a "$TARGET" "$BACKUP"

cat > "$TARGET" <<'ASTRO'
---
const cases = [
  {
    theme: "Лизинг: возврат и уменьшение неустойки",
    lead:
      "В пользу лизингополучателя взыскали излишне удержанную неустойку; снизили требования лизингодателя по пеням и санкциям.",
    items: [
      {
        num: "А40-117474/2023",
        title: "Возврат 4,75 млн ₽ и отказ от 4,03 млн ₽ встречных требований",
        short:
          "Лизингодатель удерживал неустойку внутри платежей и пытался заблокировать выкуп предмета лизинга.",
        result:
          "Кассация отменила судебные акты нижестоящих инстанций. Итог — мировое соглашение и возврат денежных средств.",
        pdfs: [
          { label: "Определение (мировое)", file: "/cases/A40-117474-2023_20250421_Opredelenie.pdf" },
          { label: "Кассация", file: "/cases/A40-117474-2023_20241203_Reshenija_i_postanovlenija.pdf" },
          { label: "Апелляция", file: "/cases/A40-117474-2023_20240819_Postanovlenie_apelljacionnoj_instancii.pdf" },
          { label: "Первая инстанция", file: "/cases/A40-117474-2023_20240503_Reshenija_i_postanovlenija.pdf" }
        ],
        href: "/cases/a40-117474-2023",
      },
    ],
  },
];
---

<section class="section" id="cases">
  <div class="container">
    <h3>Кейсы (наши успешно выполненные юридические проекты)</h3>
    <p class="muted">
      Здесь — реальные судебные истории (без раскрытия конфиденциальных деталей): задача → стратегия → процесс → результат.
      Мы показываем не «обещания», а доказуемую логику и цифры.
    </p>

    <div style="margin-top:16px; display:grid; gap:12px">
      {cases.map((group) => (
        <details class="process">
          <summary class="process-sum">
            <span class="process-title">{group.theme}</span>
            <span class="process-sub">{group.lead}</span>
            <span class="chev" aria-hidden="true"></span>
          </summary>

          <div class="process-body">
            {group.items.map((c) => (
              <div class="card" style="margin-bottom:14px">
                <b>{c.num} — {c.title}</b>
                <p class="muted">{c.short}</p>

                <ul class="list" style="margin-top:10px">
                  <li class="li">
                    <span class="check" aria-hidden="true">✓</span>
                    <div>
                      <b>Результат</b>
                      <span>{c.result}</span>
                    </div>
                  </li>
                </ul>

                <details class="block" style="margin-top:12px">
                  <summary class="block-sum">
                    <span class="block-title">Судебные акты (PDF)</span>
                    <span class="where-chev" aria-hidden="true"></span>
                  </summary>
                  <div class="block-body">
                    <ul class="list">
                      {c.pdfs.map((p) => (
                        <li class="li">
                          <span class="check" aria-hidden="true">✓</span>
                          <div>
                            <b>{p.label}</b>
                            <span>
                              <a class="phone-link" href={p.file} target="_blank" rel="noreferrer">Открыть PDF</a>
                              {" · "}
                              <a class="phone-link" href={p.file} download>Скачать</a>
                            </span>
                          </div>
                        </li>
                      ))}
                    </ul>
                  </div>
                </details>

                <div class="row" style="margin-top:12px">
                  <a class="btn primary" href={c.href}>Читать ход процесса подробно</a>
                  <a class="btn" href="#contacts">Обсудить похожую ситуацию</a>
                </div>
              </div>
            ))}
          </div>
        </details>
      ))}
    </div>
  </div>
</section>
ASTRO

echo "OK: CasesSection rewritten to native style"

SH
