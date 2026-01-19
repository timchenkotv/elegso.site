from pathlib import Path

p = Path("src/components/CasesSection.astro")
s = p.read_text(encoding="utf-8")

old = (
    "В пользу лизингополучателя взыскали излишне удержанную неустойку "
    "и добились снижения требований лизингодателя по пеням и санкциям."
)

new = (
    "В пользу лизингополучателей взыскали излишне удержанную неустойку; "
    "уменьшили размер санкций и требований лизингодателей. "
    "Защитили экономику выкупного лизинга: неустойка не может превращаться "
    "в скрытую цену договора."
)

if old not in s:
    raise SystemExit("NOT FOUND: exact lead text")

s = s.replace(old, new)
p.write_text(s, encoding="utf-8")

print("OK: lead text replaced")
