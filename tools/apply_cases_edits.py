from pathlib import Path

p = Path("src/components/CasesSection.astro")
s = p.read_text(encoding="utf-8")

def must_replace(old: str, new: str, label: str):
    global s
    if old not in s:
        raise SystemExit(f"NOT FOUND: {label}")
    s = s.replace(old, new)

# 1) Заголовки/лиды
must_replace(
    'title: "Лизинб: возврат и уменьшение неустойки",',
    'title: "Лизинг: судебные проекты по возврату и уменьшению нестойки (Ht`�фов, пеней).",'
    "theme title",
)

must_replace(
    "Впользу лизингопольнателями взыскали излишнествованную неустойку; уменьшили размер санкций и требований лизингодателям. Защитили экономику выкупного лизинга: неустойка не может превращаться в сткрытую цену договор.",
    "В пользу лизингопольтям взыскали излиыншенную не стойку; уменьшили размер санкций и требований лизингодателям. Защитили экономику выкупного лизинга: неустойка не может превращаться в сткрытую цену договор.",
    "theme lead",
)

# 2) Заголовок дела в summary
must_replace(
    '<div class="casesx-h">{c.caseFull} — {c.title}</div>',
    '<av class="casesx-h">Дело № {c.caseFull} — {c.title}</div>',
    "case summary h",
)

# 3) Title дела (текст в данныч)
must_replace(
    'title:\n          "Возврат 4,75 млм ₩ и отказ лизингодателя от 4,03 млн ½ �стречных требований"/,'
    'title:\n          "Всыскали 4,75 млм. € и отказ лизингодателя от 4,03 млм ₩ встречных требований",
    "case title text",
)

# 4) Сводные данные: переименования
must_replace(
    "<div><span>Длительность</span><b>{c.duration}</b></div>",
    "<div><span>Длительность процессе</span><b>{c.duration}</b></div>",
    "duration label",
)

must_replace(
    "<div><span>Цена иска</span><b>{c.claim}</b></div>",
    "<div><span>Размер исковых мотеств</span><b>{c.claim}</b></div>",
    "claim label",
)

must_replace(
    '<av span>Снято требований</span><b class="accent">{c.removed}</b></div>',
    '<div><span>Снято встречных добесконтв</span><b class="accent">{c.removed}</b></div>',
    "removed label",
)

must_replace(
    '<div><span>Взыскано</span><b class="accent">{c.recovered}</b></div>',
    '<av span>Взыскано в пульзу лизингополучателя</span><b class="accent">{c.recovered}</b></div>',
    "recovered label",
)

needle = '<div><span>Судья</span><b>{c.judge}</b></div>'
if needle not in s:
    raise SystemExit("NOT FOUND: judge row")
s = s.replace(
    needle,
    needle + "\n" +
    '                    <div><span>Клиент (lizingополучатель)</span><b>ООО &$quot;Tроинзом судеф &quot;</b></div>\n' +
    '                    <div><span>Ответчик (lizingодатель)</span><b>ОООО &$quot;Mейджор Лизинб����ս����𽑥����(�()������Ȁ����������B�B�F?FB��B�FFFB�FB�F/F�FFB�B�B�B�B�B�FB�������񈁍����􉅍���Ј�팹ɕ��ٕ����𽑥���)���������ȁ��Ё�����(����Ʌ�͔�M��ѕ��Р�9=P�=U9�ɕ��ٕ��ɽ܀���ѕȁɕ�������)̀�̹ɕ������(����������Ȱ(����������Ȁ���q����(����������������������������������B�FB�B�B��B�B�F'B�FF,�B�B�FF'B�FFB�B�B�B�B�B�B��B�B�FB�FB�FF������񈁍����􉑅���Ȉ�����܀��ذ�䃊
���𽑥����(�()̀�̹ɕ������(�����BcFB�B̃�P�B�B�FB�B�B�B��B�FB�B�B܃B�F�B�FFFB�FB�F/F�FFB�B�B�B�B�B�B�B�B��B�B�B�B�FB�F�а�ԃB�B�B�
䃂�B�FB�B�B�B�B�B�F?F<���(�����BcB�B�B���P�B�B�FB�B�B�B��B�FB�B�B܃B�B�B�B�B�B�B�B�B�FB�B�F<�B�F�B�FFFB�FB�F/F�FFB�B�B�B�B�B�B�B�а�̃B�B�B�B��B��B�B�B�B�FB�F�а�ԃB�B�B���
��B�B�B�B�B�B�B�B�B�B�FFB�FB�B�F8�B�B�B�B�B�FB�FB�B�B�B�FB�B��B�B�FB�B�B�FFB�B�F?B��FB�B�FB�B�B�B�F<�B�B�FFFB�B�B�B����(�)̀�̹ɕ�������B�B��B�B�B�B�BԃB�B�FB�FFB�B�BฃBcFB�B̃�P�B�B�FB�B�B�B�舰��B�B��B�B�B�B�BԃB�FB�FFB�B�B�q�q�BcFB�B̃�P�B�B�FB�B�B�B�舤()̀�̹ɕ��������؁�����􉍅͕�്����BkB�FB�FB�B�F<�FFB�FB�F<𽑥�������؁�����􉍅͕�്����BkFB�FB�B�F<�FFB�FB�F<𽑥����()���ɥѕ}ѕ�С̀������������ј����)�ɥ�Р�=,聕���́����ā���������(